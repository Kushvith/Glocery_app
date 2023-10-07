import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_proj/Providers/ProductProvider.dart';
import 'package:flutter_proj/Providers/whislistProvider.dart';
import 'package:flutter_proj/consts/firebaseconnection.dart';
import 'package:flutter_proj/services/GobalVariables.dart';
import 'package:flutter_proj/services/Utils.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
class HeartBTN extends StatefulWidget {
  const HeartBTN({Key? key, required this.productId}) : super(key: key);
final String productId;

  @override
  State<HeartBTN> createState() => _HeartBTNState();
}

class _HeartBTNState extends State<HeartBTN> {
  bool _isloading = false;
  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).color;

    final whislistprovider = Provider.of<WhilistProvider>(context);
    bool? isInWhis = whislistprovider.getWhislistItems.containsKey(widget.productId);

    return GestureDetector(
      onTap: () async {
    try{
      final User? user = authInstance.currentUser;
      if(user == null){
        GlobalVariable.waringDailog(title: "Auth Error", subtitle: "No user found,Login to continue", fn: (){Navigator.pop(context);}, context: context);
        return;
      }else{
        setState(() {
          _isloading = true;
        });
        // whislistprovider.addProductToList(productId: productId);
        if(isInWhis == false&&isInWhis !=null){
          final User? user = authInstance.currentUser;
              final _uid = user!.uid;
              final whislistId = Uuid().v4();
          await FirebaseFirestore.instance.collection('users').doc(_uid).update({
                    'userwhislist': FieldValue.arrayUnion([{
                      'whislistId': whislistId,
                      'productId': widget.productId,
                    }
                    ])
                  });
          await whislistprovider.fetch();
        }else{
          whislistprovider.removeOneItem(prodId: widget.productId,whislistId: whislistprovider.getWhislistItems[widget.productId]!.id);
        }
        setState(() {
          _isloading = false;
        });
      }
    }catch(e){
      setState(() {
        _isloading = false;
      });
    }

      },
      child: _isloading? SizedBox(height: 15,width: 15,child: CircularProgressIndicator(),): Icon(isInWhis? IconlyBold.heart:IconlyLight.heart,size: 22,color:isInWhis? Colors.red: color,),
    );
  }
}
