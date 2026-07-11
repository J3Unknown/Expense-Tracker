import 'package:expense_tracker/shared/components/constants.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/layout/cubit/main_states.dart';
import 'package:expense_tracker/module/home_screens/add_new_screen.dart';
import 'package:expense_tracker/module/home_screens/history_screen.dart';
import 'package:expense_tracker/module/home_screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/data_model.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(InitialState());

  static MainCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    HomeScreen(),
    AddNewScreen(),
    HistoryScreen(),
  ];
  int index = 0;
  final PageController pageController = PageController();
  bool isProgrammaticScroll = false;

  List<Track>? recentTracks;
  List<Track>? filteredTracks;
  late Box<Track> tracksBox;

  void initHive() async {
    tracksBox = await Hive.openBox<Track>('tracks');
    await _loadCaches();
    _calculateTotals();
    loadTracksPage(1, 20);
  }

  Future<void> _loadCaches() async {
    var box = await Hive.openBox('cache');
    AppConstants.monthlyAmount = box.get('monthlyAmount', defaultValue: 0.0);
    AppConstants.monthlyOutcome = box.get('monthlyOutcome', defaultValue: 0.0);
    AppConstants.moneyAmount = box.get('moneyAmount', defaultValue: 0.0);

    AppConstants.remainingRate = AppConstants.monthlyAmount != 0
        ? (AppConstants.moneyAmount / AppConstants.monthlyAmount) * 100
        : 0;
  }

  Future<void> _calculateTotals() async {
    final now = DateTime.now();
    double currentMonthIncome = 0;
    double currentMonthOutcome = 0;

    for (var track in tracksBox.values) {
      if (track.year == now.year && track.month == now.month) {
        if (track.type == 'income') {
          currentMonthIncome += track.amount;
        } else {
          currentMonthOutcome += track.amount;
        }
      }
    }

    AppConstants.monthlyAmount = currentMonthIncome;
    AppConstants.monthlyOutcome = currentMonthOutcome;
    AppConstants.moneyAmount = currentMonthIncome - currentMonthOutcome;

    AppConstants.remainingRate = AppConstants.monthlyAmount != 0
        ? (AppConstants.moneyAmount / AppConstants.monthlyAmount) * 100
        : 0;

    var box = await Hive.openBox('cache');
    await box.put('monthlyAmount', AppConstants.monthlyAmount);
    await box.put('monthlyOutcome', AppConstants.monthlyOutcome);
    await box.put('moneyAmount', AppConstants.moneyAmount);
  }

  void loadTracksPage(int page, int pageSize) {
    emit(TrackLoadingState());
    recentTracks = [];
    try {
      final tracks = _getPagedTracks(page, pageSize);
      if (tracks.isNotEmpty) {
        emit(TrackLoadedState(tracks));
      } else {
        emit(TrackEmptyState());
      }
    } catch (e) {
      emit(TrackErrorState(e.toString()));
    }
  }

  List<Track> _getPagedTracks(int page, int pageSize) {
    final allTracks = tracksBox.values.toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    final offset = (page - 1) * pageSize;
    if (offset >= allTracks.length) return [];
    final end = (offset + pageSize) > allTracks.length
        ? allTracks.length
        : offset + pageSize;
    return allTracks.sublist(offset, end);
  }

  Future<List<Track>> loadTracks(int page, int pageSize) async {
    final tracks = _getPagedTracks(page, pageSize);
    emit(TrackLoadedState(tracks));
    return tracks;
  }

  int? highestIncome;
  int? highestOutcome;
  int? average;

  Future<List<Track>> loadTracksWithFilters({
    int page = 1,
    int pageSize = 20,
    String? filterTimeRange,
    String? filterCategory,
    String? filterType,
  }) async {
    final now = DateTime.now();

    var tracks = tracksBox.values.toList();

    // Apply time-range filter
    if (filterTimeRange != null) {
      switch (filterTimeRange) {
        case 'day':
          tracks = tracks
              .where((t) =>
                  t.year == now.year &&
                  t.month == now.month &&
                  t.day == now.day)
              .toList();
          break;
        case 'week':
          final weekNumber = _getISOWeekNumber(now);
          tracks = tracks
              .where((t) => t.year == now.year && t.week == weekNumber)
              .toList();
          break;
        case 'month':
          tracks = tracks
              .where((t) => t.year == now.year && t.month == now.month)
              .toList();
          break;
        case 'year':
          tracks = tracks.where((t) => t.year == now.year).toList();
          break;
      }
    }

    if (filterCategory != null && filterCategory.isNotEmpty) {
      tracks = tracks.where((t) => t.category == filterCategory).toList();
    }

    if (filterType != null && filterType.isNotEmpty) {
      tracks = tracks.where((t) => t.type == filterType).toList();
    }

    tracks.sort((a, b) => b.date.compareTo(a.date));

    final offset = (page - 1) * pageSize;
    if (offset >= tracks.length) {
      emit(FilteredTrackLoadedState([]));
      return [];
    }
    final end =
        (offset + pageSize) > tracks.length ? tracks.length : offset + pageSize;
    final paged = tracks.sublist(offset, end);

    emit(FilteredTrackLoadedState(paged));
    return paged;
  }

  int _getISOWeekNumber(DateTime date) {
    final dayOfYear = int.parse(DateFormat("D").format(date));
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }

  void addTrack(Track track) async {
    final now = DateTime.now();
    final Track updatedTrack = Track(
      title: track.title,
      amount: track.amount,
      type: track.type,
      date:
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}",
      category: track.category,
      note: track.note,
      year: now.year,
      month: now.month,
      week: track.week,
      day: now.day,
      hour: now.hour,
      minute: now.minute,
    );
    emit(TrackAddingLoadingState());
    await tracksBox.add(updatedTrack);
    await _calculateTotals();
    loadTracksPage(1, 20);
    emit(TrackAddingSuccessState());
  }

  void updateTrack(Track track) async {
    await track.save();
    await _calculateTotals();
    emit(state);
  }

  void deleteTrack(Track track,
      {String? selectedCategory,
      String? selectedType,
      String? selectedTimePeriod}) async {
    await track.delete();
    await _calculateTotals();
    emit(TrackDeleteSuccessState());
    loadTracksPage(1, 20);
    loadTracksWithFilters(
        page: 1,
        pageSize: 20,
        filterType: selectedType,
        filterCategory: selectedCategory,
        filterTimeRange: selectedTimePeriod);
  }

  void changeBottomNavBarIndex(int newIndex) async {
    isProgrammaticScroll = true;
    index = newIndex;
    emit(ChangeBottomSheetIndexState());
    await pageController.animateToPage(index,
        duration: const Duration(milliseconds: 350),
        curve: Curves.fastOutSlowIn);
    isProgrammaticScroll = false;
  }

  void updateNavigationIndex(int newIndex) {
    if (!isProgrammaticScroll) {
      index = newIndex;
      emit(ChangeBottomSheetIndexState());
    }
  }
}
