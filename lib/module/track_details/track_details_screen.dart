import 'dart:developer';

import 'package:expense_tracker/layout/cubit/main_cubit.dart';
import 'package:expense_tracker/layout/cubit/main_states.dart';
import 'package:expense_tracker/models/details_screen_arguments.dart';
import 'package:expense_tracker/shared/components/icons_manager.dart';
import 'package:expense_tracker/shared/styles/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrackDetailsScreen extends StatelessWidget {
  final DetailsScreenArguments arguments;

  const TrackDetailsScreen({
    super.key,
    required this.arguments,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state){
        if(state is TrackDeleteSuccessState){
          Navigator.pop(context);
          MainCubit.get(context).changeBottomNavBarIndex(0);
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(),
        body: IconButton(onPressed: () => MainCubit.get(context).deleteTrack(arguments.track, selectedCategory: arguments.filterItems?.category, selectedTimePeriod: arguments.filterItems?.timePeriod, selectedType: arguments.filterItems?.type), icon: Icon(IconsManager.deleteIcon, color: ColorsManager.white,)),
      ),
    );
  }
}
