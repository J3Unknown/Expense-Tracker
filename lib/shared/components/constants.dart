import 'package:expense_tracker/shared/styles/colors_manager.dart';
import 'package:flutter/material.dart';

class AppConstants{
  static double moneyAmount = 0;
  static double monthlyAmount = 0;
  static double monthlyOutcome = 0;
  static double remainingRate = 0;

  static const List<DropdownMenuItem<String>> filterItems = [
    DropdownMenuItem(value: 'all time', child: Text('All Time', style: TextStyle(color: ColorsManager.white),)),
    DropdownMenuItem(value: 'day', child: Text('Day', style: TextStyle(color: ColorsManager.white))),
    DropdownMenuItem(value: 'week', child: Text('Week', style: TextStyle(color: ColorsManager.white))),
    DropdownMenuItem(value: 'month', child: Text('Month', style: TextStyle(color: ColorsManager.white))),
    DropdownMenuItem(value: 'year', child: Text('Year', style: TextStyle(color: ColorsManager.white))),
  ];

  static const List<DropdownMenuItem<String>> outcomeCategories = [
    DropdownMenuItem(value: 'bills', child: Text('Bills', style: TextStyle(color: ColorsManager.white))),
    DropdownMenuItem(value: 'debts', child: Text('Debts', style: TextStyle(color: ColorsManager.white),)),
    DropdownMenuItem(value: 'payments', child: Text('Payments', style: TextStyle(color: ColorsManager.white))),
    DropdownMenuItem(value: 'groceries', child: Text('Groceries', style: TextStyle(color: ColorsManager.white))),
    DropdownMenuItem(value: 'transfer', child: Text('Transfer', style: TextStyle(color: ColorsManager.white))),
    DropdownMenuItem(value: 'gifts', child: Text('Gifts', style: TextStyle(color: ColorsManager.white))),
  ];

  static const List<DropdownMenuItem<String>> incomeCategories = [
    DropdownMenuItem(value: 'salary', child: Text('Salary', style: TextStyle(color: ColorsManager.white),)),
    DropdownMenuItem(value: 'transfer', child: Text('Transfer', style: TextStyle(color: ColorsManager.white))),
    DropdownMenuItem(value: 'savings', child: Text('Savings', style: TextStyle(color: ColorsManager.white))),
    DropdownMenuItem(value: 'gifts', child: Text('Gifts', style: TextStyle(color: ColorsManager.white))),
  ];

  static const List<DropdownMenuItem<String>> types = [
    DropdownMenuItem(value: 'income', child: Text('Income', style: TextStyle(color: ColorsManager.white))),
    DropdownMenuItem(value: 'expense', child: Text('Outcome', style: TextStyle(color: ColorsManager.white),)),
  ];
}