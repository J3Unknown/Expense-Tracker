import 'package:expense_tracker/shared/components/assets_manager.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/components/strings_manager.dart';
import '../../../shared/components/values_manager.dart';
import '../../../shared/styles/colors_manager.dart';

class TotalAmountSection extends StatelessWidget {
  const TotalAmountSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.symmetric(horizontal: AppPaddings.p20),
      decoration: BoxDecoration(
        color: ColorsManager.primaryColor,
        borderRadius: BorderRadius.circular(AppSizesDouble.s20)
      ),
      width: double.infinity,
      height: AppSizesDouble.s150,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Positioned(
            top: -35,
            left: -screenSize(context).width/4,
            child: SvgPicture.asset(AssetsManager.background, fit: BoxFit.cover,)
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPaddings.p20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: AppSizes.s3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(StringsManager.totalAmount, style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: ColorsManager.white),),
                      SizedBox(height: AppSizesDouble.s15,),
                      Text('${AppConstants.moneyAmount} ${StringsManager.EGP}', style: Theme.of(context).textTheme.headlineLarge,),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text('${AppConstants.remainingRate <= 0?0:AppConstants.remainingRate}%', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20),),
                      PieChart(
                        PieChartData(
                          sections: [
                            PieChartSectionData(
                              value: AppConstants.remainingRate,
                              color: ColorsManager.rose,
                              radius: AppSizesDouble.s7,
                              showTitle: false
                            ),
                            PieChartSectionData(
                              value: AppSizes.s100 - AppConstants.remainingRate,
                              color: ColorsManager.grey,
                              radius: AppSizesDouble.s7,
                              showTitle: false
                            ),
                          ],
                          startDegreeOffset: AppSizesDouble.s90N
                        )
                      ),
                    ],
                  )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}