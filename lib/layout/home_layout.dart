import 'package:expense_tracker/layout/cubit/main_cubit.dart';
import 'package:expense_tracker/layout/cubit/main_states.dart';
import 'package:expense_tracker/module/widgets/bottom_navigation_bar/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/styles/colors_manager.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  bool isBottomNavTap = false;

  @override
  Widget build(BuildContext context) {
    MainCubit cubit = MainCubit.get(context);
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state){
        if(state is TrackLoadedState){
          setState(() {
            cubit.recentTracks = state.track;
          });
        }
        if(state is FilteredTrackLoadedState){
          setState(() {
            cubit.filteredTracks = state.track;
          });
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
            padding: EdgeInsets.only(top: MediaQuery.viewPaddingOf(context).top + 15),
            child: PageView(
              controller: cubit.pageController,
              children: cubit.screens,
              onPageChanged: (index){
                if(!isBottomNavTap){
                  cubit.changeBottomNavBarIndex(index);
                }
                isBottomNavTap = false;
              },
            ),
          ),
          bottomNavigationBar: BottomNavBar(
            index: cubit.index,
            onTap: (newIndex){
              isBottomNavTap = true;
              cubit.changeBottomNavBarIndex(newIndex);
            },
          ),
        ),
      ),
    );
  }
}
