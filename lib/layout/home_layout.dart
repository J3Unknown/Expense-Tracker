import 'package:expense_tracker/layout/cubit/main_cubit.dart';
import 'package:expense_tracker/layout/cubit/main_states.dart';
import 'package:expense_tracker/models/data_model.dart';
import 'package:expense_tracker/module/widgets/bottom_navigation_bar/bottom_nav_bar.dart';
import 'package:expense_tracker/shared/components/icons_manager.dart';
import 'package:expense_tracker/shared/components/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/values_manager.dart';
import '../shared/styles/colors_manager.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MainCubit cubit = MainCubit.get(context);
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state){
        if(state is TrackLoadedState){
          cubit.recentTracks = state.track;
        }
        if(state is FilteredTrackLoadedState){
          cubit.filteredTracks = state.track;
        }
      },
      builder: (context, state) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: ColorsManager.primaryColor,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: ColorsManager.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(top: AppMargins.m50),
            child: cubit.screens[cubit.index],
          ),
          bottomNavigationBar: BottomNavBar(cubit: cubit, index: cubit.index,),
        ),
      ),
    );
  }
}
