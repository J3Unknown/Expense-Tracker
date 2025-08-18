import 'package:expense_tracker/models/data_model.dart';

class DetailsScreenArguments{
  Track track;
  FilterItems? filterItems;

  DetailsScreenArguments(this.track, {this.filterItems});
}

class FilterItems{
  String timePeriod;
  String category;
  String type;

  FilterItems({required this.type, required this.category, required this.timePeriod});
}