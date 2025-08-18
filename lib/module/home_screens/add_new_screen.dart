import 'package:expense_tracker/layout/cubit/main_cubit.dart';
import 'package:expense_tracker/layout/cubit/main_states.dart';
import 'package:expense_tracker/models/data_model.dart';
import 'package:expense_tracker/module/home_screens/history_screen.dart';
import 'package:expense_tracker/shared/components/constants.dart';
import 'package:expense_tracker/shared/components/icons_manager.dart';
import 'package:expense_tracker/shared/components/strings_manager.dart';
import 'package:expense_tracker/shared/styles/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../shared/components/values_manager.dart';

class AddNewScreen extends StatefulWidget {
  const AddNewScreen({super.key});

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? category;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late bool isIncome = true;
  String? selectedDate;

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: MainCubit.get(context),
      listener: (context, state) {
        if(state is TrackAddingSuccessState){
          MainCubit.get(context).changeBottomNavBarIndex(0);
        }
      },
      child: IntrinsicHeight(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.all(AppMargins.m10),
          padding: EdgeInsets.all(AppPaddings.p15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizesDouble.s20),
            color: ColorsManager.primaryColor,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title', style: Theme.of(context).textTheme.headlineLarge,),
                  SizedBox(height: AppSizesDouble.s10,),
                  DefaultTextFormField(
                    amountController: _titleController,
                    keyboardType: TextInputType.text,
                    hint: 'payed for.....',
                    validator: (String? value){
                      if(value != null && value.isEmpty){
                        return "Title must not be empty";
                      }
                      return null;
                    },
                  ),
                  Text('Amount', style: Theme.of(context).textTheme.headlineLarge,),
                  SizedBox(height: AppSizesDouble.s10,),
                  DefaultTextFormField(
                    amountController: _amountController,
                    hint: 'Egy',
                    validator: (String? value){
                      if(value != null && value.isEmpty){
                        return "Amount must not be empty";
                      }
                      return null;
                    },
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: AppMargins.m25),
                    padding: EdgeInsets.all(AppSizesDouble.s3),
                    width: double.infinity,
                    height: AppSizesDouble.s50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizesDouble.s10),
                      color: ColorsManager.backgroundColor,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              setState(() {
                                isIncome = true;
                                category = null;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: AppSizesDouble.s50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppSizesDouble.s10),
                                color: isIncome? ColorsManager.rose:ColorsManager.backgroundColor,
                              ),
                              child: Text(StringsManager.income, style: Theme.of(context).textTheme.displaySmall!.copyWith(color: !isIncome? ColorsManager.white:ColorsManager.black),),
                            ),
                          ),
                        ),
                        SizedBox(width: AppSizesDouble.s3,),
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              setState(() {
                                isIncome = false;
                                category = null;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: AppSizesDouble.s50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppSizesDouble.s10),
                                color: !isIncome? ColorsManager.rose:ColorsManager.backgroundColor,
                              ),
                              child: Text(StringsManager.outcome, style: Theme.of(context).textTheme.displaySmall!.copyWith(color: isIncome? ColorsManager.white:ColorsManager.black),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text('Category', style: Theme.of(context).textTheme.headlineLarge,),
                  SizedBox(height: AppSizesDouble.s10,),
                  if(!isIncome)
                  CustomDropDown(
                    items: AppConstants.outcomeCategories,
                    hint: 'Outcome Category',
                    selectedItem: category,
                    onChanged: (value){
                      setState(() {
                        category = value;
                      });
                    }
                  ),
                  if(isIncome)
                  CustomDropDown(
                      items: AppConstants.incomeCategories,
                      hint: 'Income Category',
                      selectedItem: category,
                      onChanged: (value){
                        setState(() {
                          category = value;
                        });
                      }
                  ),
                  SizedBox(height: AppSizesDouble.s15,),
                  Text('Date', style: Theme.of(context).textTheme.headlineLarge,),
                  SizedBox(height: AppSizesDouble.s10,),
                  InkWell(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        firstDate: DateTime.now().subtract(Duration(days: 60)),
                        lastDate: DateTime.now(),
                        initialDate: DateTime.now()
                      ).then((value){
                        if(value != null){
                          setState(() {
                            selectedDate = DateFormat('dd / MM / yyyy').format(value);
                          });
                        }
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(AppPaddings.p20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSizesDouble.s10),
                        color: ColorsManager.backgroundColor
                      ),
                      height: 60,
                      child: Row(
                        children: [
                          Expanded(child: Text(selectedDate??'Select Transaction date', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: ColorsManager.white),)),
                          Icon(IconsManager.dateIcon, color: ColorsManager.white,)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: AppSizesDouble.s15,),
                  Text('Description', style: Theme.of(context).textTheme.headlineLarge,),
                  SizedBox(height: AppSizesDouble.s10,),
                  DefaultTextFormField(
                    amountController: _descriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                  ),
                  SizedBox(height: AppSizesDouble.s30),
                  SizedBox(
                    height: AppSizesDouble.s50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          MainCubit.get(context).addTrack(
                            Track(
                              id: 0,
                              title: _titleController.text,
                              amount: double.parse(_amountController.text),
                              type: isIncome?'income':'expense',
                              date: selectedDate!,
                              category: category!,
                              note: _descriptionController.text,
                              year: int.parse(selectedDate!.split('/').first),
                              month: int.parse(selectedDate!.split('/')[1]),
                              week: (int.parse(selectedDate!.split('/').last)/7).ceil(),
                              day: int.parse(selectedDate!.split('/').last),
                              hour: DateTime.now().hour,
                              minute: DateTime.now().minute
                            )
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.rose,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSizesDouble.s10),
                        )
                      ),
                      child: Text('Add', style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: ColorsManager.white),)
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DefaultTextFormField extends StatelessWidget {
  const DefaultTextFormField({
    super.key,
    required TextEditingController amountController,
    TextInputType keyboardType = TextInputType.number,
    this.hint,
    this.validator,
    this.maxLines = 1,
  }) : _amountController = amountController, _keyboardType = keyboardType;

  final TextEditingController _amountController;
  final TextInputType _keyboardType;
  final String? hint;
  final String? Function(String? value)? validator;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _amountController,
      validator: validator,
      keyboardType: _keyboardType,
      maxLines: maxLines,
      style: TextStyle(color: ColorsManager.white),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSizesDouble.s10),),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSizesDouble.s10),),
        filled: true,
        hintText: hint,
        hintStyle: TextStyle(color: ColorsManager.white.withValues(alpha: AppSizesDouble.s0_5)),
        fillColor: ColorsManager.backgroundColor,
      ),
      cursorColor: ColorsManager.rose,
    );
  }
}
