import 'dart:developer';

import 'package:expense_tracker/layout/cubit/main_cubit.dart';
import 'package:expense_tracker/shared/bloc_observer.dart';
import 'package:expense_tracker/shared/components/routes_manager.dart';
import 'package:expense_tracker/shared/network/local/shared_preferences.dart';
import 'package:expense_tracker/shared/network/local/theme_changer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  CacheHelper.init();
  ThemeChanger themeChanger =  ThemeChanger();
  await themeChanger.init();
  runApp(
    ChangeNotifierProvider(
      create: (context) => themeChanger,
      child: MyApp(themeChanger: themeChanger,)
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, this.themeChanger});
  final ThemeChanger? themeChanger;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainCubit>(
      create: (context) => MainCubit()..createDatabase(),
      child: ListenableBuilder(
        listenable: widget.themeChanger!,
        builder: (context, _) => MaterialApp(
          onGenerateRoute: RoutesGenerator.getRoute,
          initialRoute: Routes.homeLayout,
          debugShowCheckedModeBanner: false,
          theme: widget.themeChanger!.theme,
        ),
      ),
    );
  }
}