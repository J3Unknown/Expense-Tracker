import 'dart:developer';

import 'package:expense_tracker/shared/components/constants.dart';
import 'package:expense_tracker/shared/components/strings_manager.dart';
import 'package:expense_tracker/shared/network/local/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/layout/cubit/main_states.dart';
import 'package:expense_tracker/module/home_screens/add_new_screen.dart';
import 'package:expense_tracker/module/home_screens/analysis_screen.dart';
import 'package:expense_tracker/module/home_screens/history_screen.dart';
import 'package:expense_tracker/module/home_screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/data_model.dart';

class MainCubit extends Cubit<MainStates>{
  MainCubit() : super(InitialState());

  static MainCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    HomeScreen(),
    AddNewScreen(),
    HistoryScreen(),
    // AnalysisScreen(),
  ];
  int index = 0;

  List<Track>? recentTracks;
  List<Track>? filteredTracks;
  late Database database;

  void createDatabase() {
    openDatabase(
      'expense_tracker_database.db',
      version: 5,
      onCreate: (Database database, int version) {
        database.execute('''
        CREATE TABLE tracks (
          id INTEGER NOT NULL AUTOINCREMENT,
          PRIMARY KEY(id),
          title TEXT NOT NULL,
          amount REAL NOT NULL,
          type TEXT NOT NULL CHECK(type IN ('income', 'expense')),
          date TEXT NOT NULL,
          category TEXT,
          note TEXT,
          year INTEGER,
          month INTEGER,
          week INTEGER,
          day INTEGER,
          hour INTEGER,
          minute INTEGER
        );
      ''');
      },
      onUpgrade: (db, int oldVersion, int newVersion) async{
        if (oldVersion < 5) {
          db.delete('tracks');
          db.execute(
            '''
              CREATE TABLE tracks (
                id INTEGER NOT NULL AUTOINCREMENT,
                PRIMARY KEY(id),
                title TEXT NOT NULL,
                amount REAL NOT NULL,
                type TEXT NOT NULL CHECK(type IN ('income', 'expense')),
                date TEXT NOT NULL,
                category TEXT,
                note TEXT,
                year INTEGER,
                month INTEGER,
                week INTEGER,
                day INTEGER,
                hour INTEGER,
                minute INTEGER
              );
            '''
          );
        }
      },
      onOpen: (database) async{
        this.database = database;
        await _loadCaches();
        loadTracksPage(1, 20);
      },
    ).then((database) {
      this.database = database;
    });
  }

  Future<void> _loadCaches() async{
    // await CacheHelper.saveData(key: KeysManager.monthlyAmount, value: '0');
    // await CacheHelper.saveData(key: KeysManager.monthlyOutcome, value: '0');
    // await CacheHelper.saveData(key: KeysManager.currentAmount, value: '0');
    String monthlyOutcome = await CacheHelper.getData(key: KeysManager.monthlyOutcome)??'0';
    AppConstants.monthlyOutcome = double.parse(monthlyOutcome);
    String monthlyAmount = await CacheHelper.getData(key: KeysManager.monthlyAmount)??'0';
    AppConstants.monthlyAmount = double.parse(monthlyAmount);
    String moneyAmount = await CacheHelper.getData(key: KeysManager.currentAmount)??'0';
    AppConstants.moneyAmount = double.parse(moneyAmount);
    AppConstants.remainingRate = AppConstants.moneyAmount != 0?(AppConstants.moneyAmount/AppConstants.monthlyAmount) * 100:0;

  }

  void loadTracksPage(int page, int pageSize) {
    emit(TrackLoadingState());
    recentTracks = [];
    loadTracks(page, pageSize).then((tracks) {
      if(tracks.isNotEmpty){
        emit(TrackLoadedState(tracks));
      } else {
        emit(TrackEmptyState());
      }
    }).catchError((e) {
      emit(TrackErrorState(e.toString()));
    })
    ;
  }

  Future<List<Track>> loadTracks(int page, int pageSize) async {
    final offset = (page - 1) * pageSize;
    final result = await database.rawQuery(
      '''
        SELECT * FROM tracks
        ORDER BY date DESC
        LIMIT ? OFFSET ?
      ''',
      [pageSize, offset]
    );
    List<Track> mappedResult = result.map((data) {return Track.fromMap(data);}).toList();
    emit(TrackLoadedState(mappedResult));
    return mappedResult;
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
  })
  async {
    final offset = (page - 1) * pageSize;
    final now = DateTime.now();

    String timeCondition = '';
    List<dynamic> timeArgs = [];


    if (filterTimeRange != null) {
      switch (filterTimeRange) {
        case 'day':
          timeCondition = 'AND year = ? AND month = ? AND day = ?';
          timeArgs = [now.year, now.month, now.day];
          break;
        case 'week':
          final weekNumber = _getISOWeekNumber(now);
          timeCondition = 'AND year = ? AND week = ?';
          timeArgs = [now.year,weekNumber];
          break;
        case 'month':
          timeCondition = 'AND year = ? AND month = ?';
          timeArgs = [now.year, now.month];
          break;
        case 'year':
          timeCondition = 'AND year = ?';
          timeArgs = [now.year];
          break;
        default:
          break;
      }
    }

    String query = 'SELECT * FROM tracks WHERE 1=1';

    final args = <dynamic> [];

    if (timeCondition.isNotEmpty) {
      query += ' $timeCondition';
      args.addAll(timeArgs);
    }

    if (filterCategory != null && filterCategory.isNotEmpty) {
      query += ' AND category = ?';
      args.add(filterCategory);
    }

    if (filterType != null && filterType.isNotEmpty) {
      query += ' AND type = ?';
      args.add(filterType);
    }

    query += ' ORDER BY date DESC LIMIT ? OFFSET ?';
    args.addAll([pageSize, offset]);

    final result = await database.rawQuery(query, args);
    final mappedResult = result.map((data) => Track.fromMap(data)).toList();
    emit(FilteredTrackLoadedState(mappedResult));
    return mappedResult;
  }

  int _getISOWeekNumber(DateTime date) {
    final dayOfYear = int.parse(DateFormat("D").format(date));
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }

  void addTrack(Track track) async{
    final now = DateTime.now();
    final Track updatedTrack = Track(
      id: track.id,
      title: track.title,
      amount: track.amount,
      type: track.type,
      date: "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}",
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
    database.transaction((txn) async{
      txn.rawInsert(
        'INSERT INTO tracks(title, amount, type, date, category, note, year, month, week, day, hour, minute, second) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)',
        [
          updatedTrack.title,
          updatedTrack.amount,
          updatedTrack.type,
          updatedTrack.date,
          updatedTrack.category,
          updatedTrack.note,
          updatedTrack.year,
          updatedTrack.month,
          updatedTrack.week,
          updatedTrack.day,
          updatedTrack.hour,
          updatedTrack.minute,
        ]
      );
    }).then((value) async{
      _saveCaches(track.type, track.amount);
      loadTracksPage(1, 20);
      emit(TrackAddingSuccessState());
    });
  }

  void _saveCaches(String type, double amount) async{
    if(type == 'income'){
      AppConstants.monthlyAmount += amount;
      AppConstants.moneyAmount += amount;
    } else {
      AppConstants.moneyAmount -= amount;
      AppConstants.monthlyOutcome += amount;
    }
    AppConstants.remainingRate = AppConstants.moneyAmount > 0?((AppConstants.moneyAmount/AppConstants.monthlyAmount) * 100):0;
    await CacheHelper.saveData(key: KeysManager.currentAmount, value: AppConstants.moneyAmount.toString());
    await CacheHelper.saveData(key: KeysManager.monthlyAmount, value: AppConstants.monthlyAmount.toString());
    await CacheHelper.saveData(key: KeysManager.monthlyOutcome, value: AppConstants.monthlyOutcome.toString());
  }

  void updateTrack(Track track) async{
    emit(state);
  }

  void deleteTrack(Track track, {String? selectedCategory, String? selectedType, String? selectedTimePeriod}){
    database.rawDelete('DELETE FROM tracks WHERE id = ? ', [track.id]).then((value) {
      if(track.type == 'income'){
        _saveCaches(track.type, -track.amount);
      } else {
        _saveCaches(track.type, track.amount);
      }
      loadTracksPage(1, 20);
      loadTracksWithFilters(page: 1, pageSize: 20, filterType: selectedType, filterCategory: selectedCategory, filterTimeRange: selectedTimePeriod);
      emit(TrackDeleteSuccessState());
    });
  }

  void changeBottomNavBarIndex(newIndex){
    index = newIndex;
    emit(ChangeBottomSheetIndexState());
  }
}