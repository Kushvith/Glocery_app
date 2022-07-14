
import 'package:flutter/cupertino.dart';
import 'package:flutter_proj/services/darktheme_preferences.dart';
class themeProvider with ChangeNotifier{
  bool darktheme = false;
  Dark_theme_pref pref = Dark_theme_pref();
  bool get getDarktheme => darktheme;
  set setDarktheme(bool value){
    darktheme = value;
    pref.setTheme(value);
    notifyListeners();
  }


}