import 'package:expense_tracker/layout/home_layout.dart';
import 'package:expense_tracker/models/data_model.dart';
import 'package:expense_tracker/models/details_screen_arguments.dart';
import 'package:expense_tracker/module/home_screens/add_new_screen.dart';
import 'package:expense_tracker/module/track_details/track_details_screen.dart';
import 'package:expense_tracker/shared/components/strings_manager.dart';
import 'package:flutter/material.dart';

class Routes{
  static const String homeLayout = '/';
  static const String trackDetails = '/trackDetails';
}

class RoutesGenerator{
  static Route<dynamic> getRoute(RouteSettings settings){
    switch(settings.name){
      case Routes.homeLayout:
        return MaterialPageRoute(builder: (_) => const HomeLayout());
      case Routes.trackDetails:
        return MaterialPageRoute(builder: (_) => TrackDetailsScreen(arguments: settings.arguments as DetailsScreenArguments,));
      default:
        return unDefinedRoute();
    }
  }
  static Route<dynamic> unDefinedRoute()
  {
    return MaterialPageRoute(builder: (_) => Scaffold(
      appBar: AppBar(
        title: const Text(StringsManager.noRouteFound),
      ),
      body: const Center(child: Text(StringsManager.noRouteFound)),
    ));
  }
}