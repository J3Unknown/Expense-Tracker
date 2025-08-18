import 'package:expense_tracker/layout/cubit/main_cubit.dart';
import 'package:expense_tracker/module/home_screens/widgets/TotalAmountSection.dart';
import 'package:expense_tracker/shared/components/constants.dart';
import 'package:expense_tracker/shared/components/strings_manager.dart';
import 'package:expense_tracker/shared/components/values_manager.dart';
import 'package:expense_tracker/shared/styles/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/main_states.dart';
import '../../shared/components/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state){},
      builder: (context, state) => Padding(
        padding: EdgeInsets.all(AppPaddings.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TotalAmountSection(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IncomeOutcomeSections(
                  title: StringsManager.outcome,
                  backgroundColor: ColorsManager.softRed,
                  amount: AppConstants.monthlyOutcome,
                ),
                SizedBox(width: AppSizesDouble.s20,),
                IncomeOutcomeSections(
                  title: StringsManager.income,
                  backgroundColor: ColorsManager.softGreen,
                  amount: AppConstants.monthlyAmount,
                ),
              ],
            ),
            Divider(
              height: AppSizesDouble.s40,
              thickness: AppSizesDouble.s0_3,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: AppPaddings.p10),
                  child: Text(StringsManager.history, style: Theme.of(context).textTheme.headlineLarge,),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    MainCubit.get(context).changeBottomNavBarIndex(2);
                  },
                  child: Text('See More', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: ColorsManager.grey1),))
              ],
            ),
            Expanded(
              child: HistoryListView(
                tracks: MainCubit.get(context).recentTracks,
                state: state
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IncomeOutcomeSections extends StatelessWidget {
  final String title;
  final double amount;
  final Color backgroundColor;

  const IncomeOutcomeSections({
    super.key,
    required this.title,
    required this.amount,
    required this.backgroundColor
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: AppSizesDouble.s120,
        child: Card(
          color: backgroundColor,
          margin: EdgeInsets.symmetric(vertical: AppMargins.m20,),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPaddings.p25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(child: Text(title, style: Theme.of(context).textTheme.headlineSmall,)),
                Text(amount.toString(), style: Theme.of(context).textTheme.headlineSmall,),
              ],
            ),
          )
        ),
      ),
    );
  }
}
