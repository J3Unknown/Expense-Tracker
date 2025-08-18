import 'dart:developer';

import 'package:expense_tracker/layout/cubit/main_cubit.dart';
import 'package:expense_tracker/shared/bloc_observer.dart';
import 'package:expense_tracker/shared/components/constants.dart';
import 'package:expense_tracker/shared/components/routes_manager.dart';
import 'package:expense_tracker/shared/components/strings_manager.dart';
import 'package:expense_tracker/shared/network/local/shared_preferences.dart';
import 'package:expense_tracker/shared/styles/themes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainCubit>(
      create: (context) => MainCubit()..createDatabase(),
      child: MaterialApp(
        onGenerateRoute: RoutesGenerator.getRoute,
        initialRoute: Routes.homeLayout,
        debugShowCheckedModeBanner: false,
        theme: darkTheme(),
        darkTheme: darkTheme(),
        themeMode: ThemeMode.dark
      ),
    );
  }
}