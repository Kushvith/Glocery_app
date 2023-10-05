import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_proj/Providers/whislistProvider.dart';
import 'package:flutter_proj/consts/firebaseconnection.dart';
import 'package:flutter_proj/services/GobalVariables.dart';
import 'package:flutter_proj/services/Utils.dart';
import 'package:provider/provider.dart';
class HeartBTN extends StatelessWidget {
  const HeartBTN({Key? key, required this.productId}) : super(key: key);
final String productId;
  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).color;

    final whislistprovider = Provider.of<WhilistProvider>(context);
    bool? isInWhis = whislistprovider.getWhislistItems.containsKey(productId);
    return GestureDetector(
      onTap: (){
        final User? user = authInstance.currentUser;
        if(user == null){
          GlobalVariable.waringDailog(title: "Auth Error", subtitle: "No user found,Login to continue", fn: (){Navigator.pop(context);}, context: context);
            return;
        }else{
          whislistprovider.addProductToList(productId: productId);
        }

      },
      child: Icon(isInWhis? IconlyBold.heart:IconlyLight.heart,size: 22,color:isInWhis? Colors.red: color,),
    );
  }
}
