import 'package:flutter/material.dart';
import 'package:flutter_proj/Providers/Theme-provider.dart';
import 'package:flutter_proj/Screens/auth/forgotpassword.dart';
import 'package:flutter_proj/Screens/auth/login_page.dart';
import 'package:flutter_proj/Screens/auth/register.dart';
import 'package:flutter_proj/Screens/btm_screen.dart';
import 'package:flutter_proj/Screens/orders/order_screen.dart';
import 'package:flutter_proj/Screens/viewed/viewed_screen.dart';
import 'package:flutter_proj/Screens/whislist/Whislist_screen.dart';
import 'package:flutter_proj/consts/ThemeData.dart';
import 'package:provider/provider.dart';

import 'Inner Screens/FeedScreen.dart';
import 'Inner Screens/OnSaleScreens.dart';
import 'Inner Screens/product_details.dart';
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
          title: 'MultiStore App',
          theme: Styles.themeData(a, context),
          debugShowCheckedModeBanner: false,
          home: LoginPage(),
            routes: {
              OnsaleScreen.routeName : (context) => OnsaleScreen(),
              FeedScreen.routeName : (context) => FeedScreen(),
              ProductDetails.routeName : (context) => ProductDetails(),
              Whislist.routeName : (context) => Whislist(),
              OrderScreen.routeName : (context) => OrderScreen(),
              Viewed_screen.pathname : (context) => Viewed_screen(),
              Register_Screen.routeName : (context) => Register_Screen(),
              LoginPage.routeName : (context) => LoginPage(),
              ForgotPassPage.routeName : (context) => ForgotPassPage(),
            },
    );
        }
      ),
    );
  }
}

