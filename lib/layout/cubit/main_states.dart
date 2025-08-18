import 'package:expense_tracker/models/data_model.dart';

abstract class MainStates{}

final class InitialState extends MainStates{}

final class ChangeBottomSheetIndexState extends MainStates{}

final class GetDataFromDatabaseLoadingState extends MainStates{}

final class TrackLoadingState extends MainStates{}

final class TrackEmptyState extends MainStates{}

final class TrackLoadedState extends MainStates{
  late final List<Track> track;
  TrackLoadedState(this.track);
}

final class FilteredTrackLoadedState extends MainStates{
  late final List<Track> track;
  FilteredTrackLoadedState(this.track);
}

final class TrackErrorState  extends MainStates{
  late final String error;
  TrackErrorState (this.error);
}

final class TrackAddingLoadingState extends MainStates{}

final class TrackAddingSuccessState extends MainStates{}

final class TrackDeleteSuccessState extends MainStates{}