import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proj/Inner%20Screens/cartScreen.dart';
import 'package:flutter_proj/Providers/ProductProvider.dart';
import 'package:flutter_proj/Providers/Theme-provider.dart';
import 'package:flutter_proj/Providers/Viewed_prod.dart';
import 'package:flutter_proj/Providers/cartProvider.dart';
import 'package:flutter_proj/Screens/auth/forgotpassword.dart';
import 'package:flutter_proj/Screens/auth/login_page.dart';
import 'package:flutter_proj/Screens/auth/register.dart';
import 'package:flutter_proj/Screens/btm_screen.dart';
import 'package:flutter_proj/Screens/orders/order_screen.dart';
import 'package:flutter_proj/Screens/viewed/viewed_screen.dart';
import 'package:flutter_proj/Screens/whislist/Whislist_screen.dart';
import 'package:flutter_proj/consts/ThemeData.dart';
import 'package:flutter_proj/models/productModel.dart';
import 'package:provider/provider.dart';

import 'Inner Screens/FeedScreen.dart';
import 'Inner Screens/OnSaleScreens.dart';
import 'Inner Screens/product_details.dart';
import 'Providers/whislistProvider.dart';
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
final Future<FirebaseApp> _firebaseIntialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebaseIntialization,
      builder: (context,snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return MaterialApp(home: Scaffold(body: Center(child: CircularProgressIndicator(),),),);
        }
        else if(snapshot.hasError){
          return MaterialApp(
            home: Scaffold(
              body: Center(
               child: Text("An Error Occured"),
              ),
            ),
          );
        }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_){
              return themeprovider;
            }),
            ChangeNotifierProvider(create: (_){
              return productProvider();
            }),
            ChangeNotifierProvider(create: (_){
              return cartProvider();
            }),
            ChangeNotifierProvider(create: (_){
              return WhilistProvider();
            }),
            ChangeNotifierProvider(create: (_){
              return ViewedProdProvider();
            })
          ],
          child :Consumer<themeProvider>(
            builder: (context,themeProvider,child) {
             bool  a = themeprovider.getDarktheme;
              return MaterialApp(
              title: 'MultiStore App',
              theme: Styles.themeData(a, context),
              debugShowCheckedModeBanner: false,
              home:Btm_screeen(),
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
                  CatScreen.routeName : (context)=> CatScreen(),
                },
        );
            }
          ),
        );
      }
    );
  }
}

