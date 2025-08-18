import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:expense_tracker/models/details_screen_arguments.dart';
import 'package:expense_tracker/shared/components/routes_manager.dart';
import 'package:expense_tracker/shared/components/strings_manager.dart';
import 'package:expense_tracker/shared/components/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../layout/cubit/main_states.dart';
import '../../models/data_model.dart';
import '../styles/colors_manager.dart';
import 'assets_manager.dart';
import 'icons_manager.dart';

class TrackCard extends StatelessWidget {
  final Track track;
  final FilterItems? filterItems;
  const TrackCard({
    super.key,
    required this.track,
    this.filterItems
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.trackDetails, arguments: DetailsScreenArguments(track, filterItems: filterItems)))),
      child: Card(
        shadowColor: ColorsManager.shadowColor,
        elevation: AppSizesDouble.s5,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPaddings.p5, vertical: AppPaddings.p20),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPaddings.p15),
                child: SvgPicture.asset(track.type.getIcon(), width: AppSizesDouble.s40,),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(track.title, style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.bold), maxLines: AppSizes.s1, overflow: TextOverflow.ellipsis,),
                    Text(track.amount.toString(), style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: ColorsManager.grey1), maxLines: AppSizes.s1, overflow: TextOverflow.ellipsis)
                  ],
                ),
              ),
              Icon(IconsManager.rightArrowIcon, color: ColorsManager.white,),
            ],
          ),
        ),
      ),
    );
  }
}

class HistoryListView extends StatelessWidget {
  const HistoryListView({
    super.key,
    required this.tracks,
    required this.state,
    this.isHistory = false,
    this.filterItems
  });

  final List<Track>? tracks;
  final dynamic state;
  final bool isHistory;
  final FilterItems? filterItems;
  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: tracks != null && tracks!.isNotEmpty && state is !TrackLoadingState,
      builder: (context) => ListView.separated(
        physics: !isHistory?NeverScrollableScrollPhysics():BouncingScrollPhysics(),
        itemBuilder: (context, index) => TrackCard(
          track: tracks![index],
          filterItems: filterItems,
        ),
        itemCount: isHistory? tracks!.length: tracks!.length < 3? tracks!.length:3,
        separatorBuilder: (context, index) => SizedBox(height: AppSizesDouble.s10,),
      ),
      fallback: (context) {
        if(state is TrackLoadedState && tracks == null){
          return Center(child: CircularProgressIndicator());
        }
        return Center(
          child: Padding(
            padding: EdgeInsets.all(AppPaddings.p10),
            child: Text(
              StringsManager.emptyTracksMessage,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: ColorsManager.white),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}

extension GetIconExtension on String{
  String getIcon(){
    switch(this){
      case 'income':
        return AssetsManager.income;
      case 'expense':
        return AssetsManager.outcome;
      default:
        return AssetsManager.income;

    }
  }
}