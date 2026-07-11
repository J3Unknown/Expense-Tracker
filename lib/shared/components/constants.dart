import 'package:flutter/material.dart';

class AppConstants{
  static double moneyAmount = 0;
  static double monthlyAmount = 0;
  static double monthlyOutcome = 0;
  static double remainingRate = 0;

  static const List<DropdownMenuItem<String>> filterItems = [
    DropdownMenuItem(value: 'all-time', child: Text('All Time')),
    DropdownMenuItem(value: 'day', child: Text('Day')),
    DropdownMenuItem(value: 'week', child: Text('Week')),
    DropdownMenuItem(value: 'month', child: Text('Month')),
    DropdownMenuItem(value: 'year', child: Text('Year')),
  ];

  static const List<DropdownMenuItem<String>> outcomeCategories = [
    DropdownMenuItem(value: 'bills', child: Text('Bills')),
    DropdownMenuItem(value: 'debts', child: Text('Debts')),
    DropdownMenuItem(value: 'rent', child: Text('Rent')),
    DropdownMenuItem(value: 'utilities', child: Text('Utilities')),
    DropdownMenuItem(value: 'groceries', child: Text('Groceries')),
    DropdownMenuItem(value: 'transportation', child: Text('Transportation')),
    DropdownMenuItem(value: 'dining-out', child: Text('Dining Out')),
    DropdownMenuItem(value: 'drinks-snacks', child: Text('Drinks / Snacks')),
    DropdownMenuItem(value: 'shopping', child: Text('Shopping')),
    DropdownMenuItem(value: 'entertainment', child: Text('Entertainment')),
    DropdownMenuItem(value: 'transfer', child: Text('Transfer')),
    DropdownMenuItem(value: 'subscriptions', child: Text('Subscriptions')),
    DropdownMenuItem(value: 'courses-education', child: Text('Courses / Education')),
    DropdownMenuItem(value: 'business-expenses', child: Text('Business Expenses')),
    DropdownMenuItem(value: 'medical-bills', child: Text('Medical Bills')),
    DropdownMenuItem(value: 'medicine', child: Text('Medicine')),
    DropdownMenuItem(value: 'gym', child: Text('Gym')),
    DropdownMenuItem(value: 'gifts', child: Text('Gifts')),
    DropdownMenuItem(value: 'insurance', child: Text('Insurance')),
    DropdownMenuItem(value: 'donations', child: Text('Donations')),
    DropdownMenuItem(value: 'family-support', child: Text('Family Support')),
    DropdownMenuItem(value: 'events', child: Text('Events')),
    DropdownMenuItem(value: 'hobbies', child: Text('Hobbies')),
    DropdownMenuItem(value: 'payments', child: Text('Payments')),
    DropdownMenuItem(value: 'losses', child: Text('Losses')),
    DropdownMenuItem(value: 'other', child: Text('other')),
  ];

  static const List<DropdownMenuItem<String>> incomeCategories = [
    DropdownMenuItem(value: 'salary', child: Text('Salary')),
    DropdownMenuItem(value: 'freelance', child: Text('Freelance')),
    DropdownMenuItem(value: 'business-income', child: Text('Business Income')),
    DropdownMenuItem(value: 'lending', child: Text('Lending')),
    DropdownMenuItem(value: 'transfer', child: Text('Transfer')),
    DropdownMenuItem(value: 'gifts', child: Text('Gifts')),
    DropdownMenuItem(value: 'investments', child: Text('Investments')),
    DropdownMenuItem(value: 'rental-income', child: Text('Rental Income')),
    DropdownMenuItem(value: 'bonuses', child: Text('Bonuses')),
    DropdownMenuItem(value: 'savings', child: Text('Savings')),
  ];

  static const List<DropdownMenuItem<String>> types = [
    DropdownMenuItem(value: 'income', child: Text('Income')),
    DropdownMenuItem(value: 'expense', child: Text('Outcome')),
  ];
}