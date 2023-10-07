import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proj/Providers/cartProvider.dart';
import 'package:flutter_proj/Providers/whislistProvider.dart';
import 'package:flutter_proj/consts/contss.dart';
import 'package:flutter_proj/consts/firebaseconnection.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../Providers/ProductProvider.dart';
import 'btm_screen.dart';

class Fetch_Screen extends StatefulWidget {
  const Fetch_Screen({Key? key}) : super(key: key);

  @override
  State<Fetch_Screen> createState() => _Fetch_ScreenState();
}

class _Fetch_ScreenState extends State<Fetch_Screen> {
 @override
  void initState() {
    // TODO: implement initState
   Future.delayed(Duration(microseconds: 5),
       () async{
     final productprovider = Provider.of<productProvider>(context,listen: false);
     final cartprovider = Provider.of<cartProvider>(context,listen: false);
     final whislistprovider = Provider.of<WhilistProvider>(context,listen: false);
     final User? user = authInstance.currentUser;

     if(user == null){
     await productprovider.fetch_products();
     }
     else{
       await productprovider.fetch_products();
       await cartprovider.fetchCart();
       await whislistprovider.fetch();
     }
     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=> Btm_screeen()));
     
       }
   );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   List<String> images = constss.LoginpageImages;
   images.shuffle();
    return  Scaffold(
      body: Stack(
        children: [
          Image.asset(images[0],fit: BoxFit.cover,height: double.infinity,),
          Container(color: Colors.black.withOpacity(0.7),),
          Center(
            child: SpinKitFadingFour(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
