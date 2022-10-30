import 'package:flutter/material.dart';
import 'package:flutter_proj/Providers/Theme-provider.dart';
import 'package:flutter_proj/Screens/btm_screen.dart';
import 'package:flutter_proj/Screens/orders/order_screen.dart';
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
          home: Btm_screeen(),
            routes: {
              OnsaleScreen.routeName : (context) => OnsaleScreen(),
              FeedScreen.routeName : (context) => FeedScreen(),
              ProductDetails.routeName : (context) => ProductDetails(),
              Whislist.routeName : (context) => Whislist(),
              OrderScreen.routeName : (context) => OrderScreen(),


            },
    );
        }
      ),
    );
  }
}

