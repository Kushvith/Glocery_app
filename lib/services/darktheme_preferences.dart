import 'package:shared_preferences/shared_preferences.dart';

class Dark_theme_pref{
  static var StatusTheme = "STATUSTHEME";
  setTheme(bool value) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(StatusTheme, value);
  }
  Future <bool> getTheme() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(StatusTheme) ?? false;
  }
}