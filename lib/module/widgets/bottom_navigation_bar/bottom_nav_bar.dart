import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:expense_tracker/shared/components/assets_manager.dart';
import 'package:expense_tracker/shared/components/values_manager.dart';
import 'package:expense_tracker/shared/styles/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.onTap, this.index = 0});
  final int index;
  final ValueChanged onTap;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        color: Theme.of(context).primaryColor,
        index: index,
        items: [
          Padding(
            padding: EdgeInsets.all(AppPaddings.p7),
            child: SvgPicture.asset(AssetsManager.home,
                colorFilter: ColorFilter.mode(
                    index == 0 ? ColorsManager.rose : ColorsManager.grey1,
                    BlendMode.srcIn)),
          ),
          Padding(
            padding: const EdgeInsets.all(AppPaddings.p7),
            child: SvgPicture.asset(AssetsManager.add,
                colorFilter: ColorFilter.mode(
                    index == 1 ? ColorsManager.rose : ColorsManager.grey1,
                    BlendMode.srcIn)),
          ),
          Padding(
            padding: const EdgeInsets.all(AppPaddings.p7),
            child: SvgPicture.asset(AssetsManager.history,
                colorFilter: ColorFilter.mode(
                    index == 2 ? ColorsManager.rose : ColorsManager.grey1,
                    BlendMode.srcIn)),
          ),
        ],
        animationCurve: Curves.fastEaseInToSlowEaseOut,
        buttonBackgroundColor: Theme.of(context).primaryColor,
        onTap: onTap);
  }
}
