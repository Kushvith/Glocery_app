import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_proj/models/cartModel.dart';
import 'package:flutter_proj/models/whilist_model.dart';
import 'package:uuid/uuid.dart';

import '../consts/firebaseconnection.dart';

class WhilistProvider extends ChangeNotifier{
  Map<String,whislistModel> _whislistItems = {};
  Map<String,whislistModel> get getWhislistItems{
    return _whislistItems;
  }
  // void addProductToList({
  //   required String productId,
  // })
  // async{
  //   if(_whislistItems.containsKey(productId)){
  //     removeOneItem(productId);
  //   }else {
  //     final User? user = authInstance.currentUser;
  //     final _uid = user!.uid;
  //     final whislistId = Uuid().v4();
  //     try {
  //       await FirebaseFirestore.instance.collection('users').doc(_uid).update({
  //         'userwhislist': FieldValue.arrayUnion([{
  //           'whislistId': whislistId,
  //           'productId': productId,
  //         }
  //         ])
  //       });
  //     } catch (e) {
  //       print(e);
  //     }
  //     // if(getWhislistItems.containsKey(productId)){
  //     //   _whislistItems.remove(productId);
  //     //
  //     // }
  //     // else{
  //     //   _whislistItems.putIfAbsent(productId, () =>
  //     //       whislistModel(id: DateTime.now().toString(), prodid: productId ));
  //     // }
  //   }
  //   notifyListeners();
  // }
Future<void> fetch() async{
  final User? user = authInstance.currentUser;
  String _uid = user!.uid;
  final userDoc =
  await FirebaseFirestore.instance.collection('users').doc(_uid).get();
  if(userDoc == null){
    return;
  }
  final leng =  userDoc.get('userwhislist').length;
  for(int i=0;i<leng;i++){
    _whislistItems.putIfAbsent(userDoc.get('userwhislist')[i]['productId'], () =>
        whislistModel(id: userDoc.get('userwhislist')[i]['whislistId'], prodid: userDoc.get('userwhislist')[i]['productId']));
  }
  print(_whislistItems);
  ChangeNotifier();
}
  Future<void> removeOneItem({required String prodId,required String whislistId}) async {
    final User? user = authInstance.currentUser;
    final _uid = user!.uid;
    try {
      await FirebaseFirestore.instance.collection('users').doc(_uid).update({
        'userwhislist': FieldValue.arrayRemove([{
          'whislistId': whislistId,
          'productId': prodId,
        }
        ])
      });
    } catch (e) {
      print(e);
    }
    _whislistItems.remove(prodId);
    fetch();
    notifyListeners();
  }
  Future<void> clearCart() async {
    final User? user = authInstance.currentUser;
    final _uid = user!.uid;
    await FirebaseFirestore.instance.collection('users').doc(_uid).update({
      'userwhislist': []

    });
    fetch();
    _whislistItems.clear();
    notifyListeners();
  }
}