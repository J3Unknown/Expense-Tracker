import 'package:expense_tracker/layout/cubit/main_cubit.dart';
import 'package:expense_tracker/models/data_model.dart';
import 'package:expense_tracker/module/home_screens/history_screen.dart';
import 'package:expense_tracker/module/home_screens/widgets/TotalAmountSection.dart';
import 'package:expense_tracker/shared/components/constants.dart';
import 'package:expense_tracker/shared/components/strings_manager.dart';
import 'package:expense_tracker/shared/components/values_manager.dart';
import 'package:expense_tracker/shared/styles/colors_manager.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {

  String? selectedFilter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppPaddings.p20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screenSize(context).width/AppSizesDouble.s2_5,
              child: CustomDropDown(
                items: AppConstants.filterItems,
                hint: StringsManager.selectPeriod,
                selectedItem: selectedFilter,
                onChanged: (value){
                  setState(() {
                    selectedFilter = value;
                  });
                  _getFilteredData(context, selectedFilter);
                }
              ),
            ),
            SizedBox(height: AppSizesDouble.s20,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizesDouble.s10),
                color: ColorsManager.primaryColor,
              ),
              padding: EdgeInsets.symmetric(vertical: AppPaddings.p20, horizontal: AppPaddings.p10),
              width: double.infinity,
              height: screenSize(context).height/AppSizesDouble.s2_3,
              child: FutureBuilder<List<Track>>(
                future: MainCubit.get(context).loadTracksWithFilters(filterTimeRange: selectedFilter),
                builder: (context, snapshot) {
                  // if(!snapshot.hasData || snapshot.data!.isEmpty){
                  //   return Center(child: Text(StringsManager.noData, style: Theme.of(context).textTheme.headlineMedium,),);
                  // }
                   return Padding(
                     padding: EdgeInsets.symmetric(vertical: AppPaddings.p5),
                     child: BarChart(
                       BarChartData(
                         maxY: 10,
                         minY: 0,
                         borderData: FlBorderData(
                           border: Border.all(color: ColorsManager.white),
                         ),
                         titlesData: FlTitlesData(

                           topTitles: AxisTitles(
                             axisNameWidget: Text('', style: Theme.of(context).textTheme.titleMedium,),
                           ),
                           rightTitles: AxisTitles(
                             axisNameWidget: Text('Amount', style: Theme.of(context).textTheme.titleMedium,),
                           ),
                         ),
                         gridData: FlGridData(
                           horizontalInterval: 1,
                           drawVerticalLine: false,
                         ),
                         barGroups:[
                           BarChartGroupData(
                             x: 1,
                             barsSpace: 1,
                             barRods: [
                               BarChartRodData(toY: 5,color: ColorsManager.softRed, borderRadius: BorderRadius.vertical(top: Radius.circular(10)),),
                               BarChartRodData(toY: 7, color: ColorsManager.softGreen, borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
                               BarChartRodData(toY: 4, color: ColorsManager.white, borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
                             ],
                           ),
                           BarChartGroupData(
                             x: 2,
                             barsSpace: 1,
                             barRods: [
                               BarChartRodData(toY: 5,color: ColorsManager.softRed, borderRadius: BorderRadius.vertical(top: Radius.circular(10)),),
                               BarChartRodData(toY: 7, color: ColorsManager.softGreen, borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
                               BarChartRodData(toY: 4, color: ColorsManager.white, borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
                             ],
                           ),
                           BarChartGroupData(
                             x: 3,
                             barsSpace: 1,
                             barRods: [
                               BarChartRodData(toY: 5,color: ColorsManager.softRed, borderRadius: BorderRadius.vertical(top: Radius.circular(10)),),
                               BarChartRodData(toY: 7, color: ColorsManager.softGreen, borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
                               BarChartRodData(toY: 4, color: ColorsManager.white, borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
                             ],
                           ),
                           BarChartGroupData(
                             x: 4,
                             barsSpace: 1,
                             barRods: [
                               BarChartRodData(toY: 5,color: ColorsManager.softRed, borderRadius: BorderRadius.vertical(top: Radius.circular(10)),),
                               BarChartRodData(toY: 7, color: ColorsManager.softGreen, borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
                               BarChartRodData(toY: 4, color: ColorsManager.white, borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
                             ],
                           ),
                           BarChartGroupData(
                             x: 5,
                             barsSpace: 1,
                             barRods: [
                               BarChartRodData(toY: 5,color: ColorsManager.softRed, borderRadius: BorderRadius.vertical(top: Radius.circular(10)),),
                               BarChartRodData(toY: 7, color: ColorsManager.softGreen, borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
                               BarChartRodData(toY: 4, color: ColorsManager.white, borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
                             ],
                           ),
                           BarChartGroupData(
                             x: 6,
                             barsSpace: 1,
                             barRods: [
                               BarChartRodData(toY: 5,color: ColorsManager.softRed, borderRadius: BorderRadius.vertical(top: Radius.circular(10)),),
                               BarChartRodData(toY: 7, color: ColorsManager.softGreen, borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
                               BarChartRodData(toY: 4, color: ColorsManager.white, borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
                             ],
                           ),
                           BarChartGroupData(
                             x: 7,
                             barsSpace: 1,
                             barRods: [
                               BarChartRodData(toY: 5,color: ColorsManager.softRed, borderRadius: BorderRadius.vertical(top: Radius.circular(10)),),
                               BarChartRodData(toY: 7, color: ColorsManager.softGreen, borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
                               BarChartRodData(toY: 4, color: ColorsManager.white, borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
                             ],
                           ),
                         ],
                       ),

                       duration: Duration(milliseconds: AppSizes.s300),
                       curve: Curves.fastEaseInToSlowEaseOut,
                     ),
                   );
                },
              ),
            ),
            SizedBox(height: AppSizesDouble.s20,),
            Row(
              children: [
                IncomeOutcomeLineIndicator(
                  title: StringsManager.outcome,
                  color: ColorsManager.softRed
                ),
                SizedBox(width: AppSizesDouble.s20,),
                IncomeOutcomeLineIndicator(
                    title: StringsManager.income,
                    color: ColorsManager.softGreen
                ),
              ],
            ),
            SizedBox(height: AppSizesDouble.s20,),
            TotalAmountSection()
          ],
        ),
      ),
    );
  }
}

_getFilteredData(context, filterRange){
  MainCubit.get(context).loadTracksWithFilters(
    filterTimeRange: filterRange,
  );
}

class IncomeOutcomeLineIndicator extends StatelessWidget {
  const IncomeOutcomeLineIndicator({
    super.key,
    required this.title,
    required this.color,
  });

  final Color color;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: AppSizesDouble.s70,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizesDouble.s10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(child: Text(title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium,)),
              SizedBox(width: AppSizesDouble.s10,),
              SizedBox(
                height: AppSizesDouble.s5,
                width: AppSizesDouble.s30,
                child: Card(
                  margin: EdgeInsets.only(right: AppSizesDouble.s10),
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
