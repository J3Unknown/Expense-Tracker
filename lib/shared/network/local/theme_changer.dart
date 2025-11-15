import 'package:expense_tracker/shared/components/strings_manager.dart';
import 'package:expense_tracker/shared/network/local/shared_preferences.dart';
import 'package:expense_tracker/shared/styles/themes_manager.dart';
import 'package:flutter/material.dart';

class ThemeChanger extends ChangeNotifier{
  bool isDark = true;
  ThemeData theme = darkTheme();
  
  Future<void> init() async{
    String sTheme = await CacheHelper.getData(key: KeysManager.theme)??'dark';
    isDark = sTheme == 'dark'?true:false;
    theme = isDark? darkTheme():lightTheme();
    notifyListeners();
  }

  void changeTheme(){
    isDark = !isDark;
    theme = isDark?darkTheme():lightTheme();
    CacheHelper.saveData(key: KeysManager.theme, value: isDark?'dark':'light');
    notifyListeners();
  }

}