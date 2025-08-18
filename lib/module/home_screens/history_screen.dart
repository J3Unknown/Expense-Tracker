import 'package:expense_tracker/layout/cubit/main_cubit.dart';
import 'package:expense_tracker/models/details_screen_arguments.dart';
import 'package:expense_tracker/shared/components/assets_manager.dart';
import 'package:expense_tracker/shared/components/components.dart';
import 'package:expense_tracker/shared/components/constants.dart';
import 'package:expense_tracker/shared/components/values_manager.dart';
import 'package:expense_tracker/shared/styles/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/data_model.dart';
import '../../shared/components/strings_manager.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<DropdownMenuItem<String>> categoryItems = [];
  String? typeSelectedItem;
  String? selectedDate;
  String? categorySelectedItem;

  List<Track> tracks = [];

  @override
  void initState() {
    initAwaits();
    super.initState();
  }

  initAwaits() async{
    tracks = await context.read<MainCubit>().loadTracks(1, 20);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizesDouble.s10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomDropDown(
                  items: AppConstants.types,
                  hint: 'Type',
                  selectedItem: typeSelectedItem,
                  onChanged: (value){
                    setState(() {
                      typeSelectedItem = value;
                      if(typeSelectedItem == 'income'){
                        setState(() {
                          categorySelectedItem = null;
                          categoryItems = AppConstants.incomeCategories;
                        });
                      } else{
                        setState(() {
                          categorySelectedItem = null;
                          categoryItems = AppConstants.outcomeCategories;
                        });
                      }
                    });
                  },
                ),
              ),
              SizedBox(width: AppPaddings.p15,),
              Expanded(
                child: CustomDropDown(
                  items: categoryItems,
                  hint: 'Category',
                  selectedItem: categorySelectedItem,
                  onChanged: (value) {
                    setState(() {
                      categorySelectedItem = value;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizesDouble.s15,),
          Row(
            children: [
              Expanded(
                // child: InkWell(
                //   onTap: ()  {
                //     showDatePicker(context: context, firstDate: DateTime.now().subtract(Duration(days: 356)), lastDate: DateTime.now()).then((value){
                //       if(value != null){
                //         setState(() {
                //           selectedDate = value;
                //         });
                //       }
                //     });
                //   },
                //   child: Container(
                //     padding: EdgeInsets.symmetric(horizontal: AppPaddings.p15),
                //     height: AppSizesDouble.s50,
                //     alignment: Alignment.centerLeft,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(AppSizesDouble.s10),
                //       color: ColorsManager.primaryColor
                //     ),
                //     child: Row(
                //       children: [
                //         Text('${selectedDate.day} - ${selectedDate.month} - ${selectedDate.year}',style: Theme.of(context).textTheme.titleMedium,),
                //         Spacer(),
                //         SvgPicture.asset(AssetsManager.calender, width: AppSizesDouble.s30,)
                //       ],
                //     )
                //   ),
                // ),
                child: SizedBox(
                  width: screenSize(context).width/AppSizesDouble.s2_5,
                  child: CustomDropDown(
                    items: AppConstants.filterItems,
                    hint: StringsManager.selectPeriod,
                    selectedItem: selectedDate,
                    onChanged: (value){
                      setState(() {
                        selectedDate = value;
                      });
                    }
                  ),
                ),
              ),
              SizedBox(width: AppSizesDouble.s15,),
              ElevatedButton(
                onPressed: ()async{
                  tracks = await MainCubit.get(context).loadTracksWithFilters(
                    filterCategory: categorySelectedItem,
                    filterType: typeSelectedItem,
                    filterTimeRange: selectedDate
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizesDouble.s10)),
                  backgroundColor: ColorsManager.rose,
                  padding: EdgeInsets.symmetric(horizontal: AppPaddings.p30, vertical: AppPaddings.p15)
                ),
                child: Text('Apply', style: TextStyle(color: ColorsManager.white),),
              ),
            ],
          ),
          SizedBox(
            height: AppSizesDouble.s20,
          ),
          Expanded(
            child: BlocBuilder(
              bloc: MainCubit.get(context),
              builder: (context, state) {
                return HistoryListView(
                  tracks: tracks,
                  state: state,
                  isHistory: true,
                  filterItems: FilterItems(type: typeSelectedItem??'', timePeriod: selectedDate??'', category: categorySelectedItem??''),
                );
              }
            ),
          )
        ],
      ),
    );
  }
}

class CustomDropDown extends StatefulWidget {

  const CustomDropDown({
    super.key,
    required this.items,
    required this.hint,
    required this.selectedItem,
    required this.onChanged
  });

  final List<DropdownMenuItem<String>> items;
  final String hint;
  final String? selectedItem;
  final ValueChanged<String?> onChanged;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppPaddings.p15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizesDouble.s10),
        color: ColorsManager.primaryColor
      ),
      child: DropdownButton(
        items: widget.items,
        value: widget.selectedItem,
        onChanged: (value) => widget.onChanged(value),
        selectedItemBuilder: (context) => widget.items.map((e) {
          return DropdownMenuItem(value: e.value, child: Text((e.child as Text).data!, style: Theme.of(context).textTheme.titleMedium, ),);
        }).toList(),
        isExpanded: true,
        underline: SizedBox(),
        hint: Text(widget.hint, style: TextStyle(color: ColorsManager.white),),
        icon: Icon(Icons.arrow_drop_down, color: ColorsManager.white),
        dropdownColor: ColorsManager.primaryColor,
        style: TextStyle(color: ColorsManager.black),
      ),
    );
  }
}
