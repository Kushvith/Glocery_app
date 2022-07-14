import 'package:flutter/material.dart';
import 'package:flutter_proj/Providers/Theme-provider.dart';
import 'package:flutter_proj/Screens/Home_screens.dart';
import 'package:flutter_proj/consts/ThemeData.dart';
import 'package:flutter_proj/services/darktheme_preferences.dart';
import 'package:provider/provider.dart';
void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  themeProvider themeprovider = themeProvider();

  void gettheme() async{
    themeprovider.setDarktheme = await themeprovider.pref.getTheme();
  }
@override
  void initState() {
    // TODO: implement initState
  gettheme();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_){
          return themeprovider;
        })
      ],
      child :Consumer<themeProvider>(
        builder: (context,themeProvider,child) {
         bool  a = themeprovider.getDarktheme;
          return MaterialApp(
          title: 'Flutter Demo',
          theme: Styles.themeData(a, context),
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
    );
        }
      ),
    );
  }
}

