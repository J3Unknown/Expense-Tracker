import 'package:expense_tracker/layout/cubit/main_cubit.dart';
import 'package:expense_tracker/layout/cubit/main_states.dart';
import 'package:expense_tracker/models/details_screen_arguments.dart';
import 'package:expense_tracker/module/home_screens/add_new_screen.dart';
import 'package:expense_tracker/shared/components/icons_manager.dart';
import 'package:expense_tracker/shared/styles/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../shared/components/values_manager.dart';

class TrackDetailsScreen extends StatefulWidget {
  final DetailsScreenArguments arguments;

  const TrackDetailsScreen({
    super.key,
    required this.arguments,
  });

  @override
  State<TrackDetailsScreen> createState() => _TrackDetailsScreenState();
}

class _TrackDetailsScreenState extends State<TrackDetailsScreen> {
  late final TextEditingController _amountController;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    _amountController =
        TextEditingController(text: widget.arguments.track.amount.toString());
    _titleController =
        TextEditingController(text: widget.arguments.track.title);
    _descriptionController =
        TextEditingController(text: widget.arguments.track.note);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {
        if (state is TrackDeleteSuccessState) {
          Navigator.pop(context);
          MainCubit.get(context).changeBottomNavBarIndex(0);
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () => MainCubit.get(context).deleteTrack(
                    widget.arguments.track,
                    selectedCategory: widget.arguments.filterItems?.category,
                    selectedTimePeriod:
                        widget.arguments.filterItems?.timePeriod,
                    selectedType: widget.arguments.filterItems?.type),
                icon: Icon(
                  IconsManager.deleteIcon,
                  color: ColorsManager.softRed,
                )),
          ],
        ),
        body: IntrinsicHeight(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.all(AppMargins.m10),
            padding: EdgeInsets.all(AppPaddings.p15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizesDouble.s20),
              color: ColorsManager.primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(
                  height: AppSizesDouble.s10,
                ),
                DefaultTextFormField(
                  amountController: _titleController,
                  keyboardType: TextInputType.text,
                  hint: 'payed for.....',
                  readOnly: true,
                  validator: (String? value) {
                    if (value != null && value.isEmpty) {
                      return "Title must not be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: AppSizesDouble.s15,
                ),
                Text(
                  'Amount',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(
                  height: AppSizesDouble.s10,
                ),
                DefaultTextFormField(
                  readOnly: true,
                  amountController: _amountController,
                  hint: 'Egy',
                  validator: (String? value) {
                    if (value != null && value.isEmpty) {
                      return "Amount must not be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: AppSizesDouble.s15,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Type: ',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    TextSpan(
                      text: widget.arguments.track.type,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                              color: widget.arguments.track.type == 'expense'
                                  ? ColorsManager.softRed
                                  : ColorsManager.softGreen),
                    ),
                  ]),
                ),
                SizedBox(
                  height: AppSizesDouble.s15,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Category: ',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    TextSpan(
                        text: widget.arguments.track.category,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: ColorsManager.rose)),
                  ]),
                ),
                SizedBox(
                  height: AppSizesDouble.s15,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Date: ',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    TextSpan(
                      text: DateFormat('EEE, dd/MM/yyyy - hh:mm aa')
                          .format(DateTime.parse(widget.arguments.track.date)),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ]),
                ),
                SizedBox(
                  height: AppSizesDouble.s15,
                ),
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(
                  height: AppSizesDouble.s10,
                ),
                DefaultTextFormField(
                  readOnly: true,
                  amountController: _descriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
