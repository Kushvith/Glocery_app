import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proj/consts/firebaseconnection.dart';
import 'package:flutter_proj/models/cartModel.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:uuid/uuid.dart';

class cartProvider extends ChangeNotifier{
  Map<String,cartModel> _cartItems = {};
  Map<String,cartModel> get getCartItems{
    return _cartItems;
  }
//   void addProductToList({
//     required String productId,
//     required int quantity
// })
//   {
//     _cartItems.putIfAbsent(productId, () =>
//     cartModel(id: DateTime.now().toString(), prodid: productId, quantity: quantity ));
//     notifyListeners();
//   }
   Future<void> addToCart({
    required String productId,
    required int quantity,
    required BuildContext context
  })async{
    final User? user = authInstance.currentUser;
    final _uid = user!.uid;
    final cartId = Uuid().v4();
    try{

    await FirebaseFirestore.instance.collection('users').doc(_uid).update({
      'userCart':FieldValue.arrayUnion([{
        'cartId':cartId,
        'productId':productId,
        'quantity':quantity
      }])
    });
    }catch(err){
      //Simple to use, no global configuration
      showToast("hello styled toast",context:context);
      print('error occured');

    }
    await fetchCart();
    notifyListeners();
  }
Future<void> fetchCart() async{
    final User? user = authInstance.currentUser;
    String _uid = user!.uid;
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
        if(userDoc == null){
          return;
        }
       final leng =  userDoc.get('userCart').length;
        for(int i=0;i<leng;i++){
          _cartItems.putIfAbsent(userDoc.get('userCart')[i]['productId'], () =>
          cartModel(id: userDoc.get('userCart')[i]['cartId'], prodid: userDoc.get('userCart')[i]['productId'], quantity: userDoc.get('userCart')[i]['quantity']));
        }
        print(_cartItems);
    notifyListeners();
}
  Future<void> ReduceQuantityByOne({required String prodId,required int quantity})
  async{
    final User? user = authInstance.currentUser;
    String _uid = user!.uid;
    await FirebaseFirestore.instance.collection('users').doc(_uid).update({
      'userCart': FieldValue.arrayUnion([{
        'productId': prodId,
        'quantity': quantity
      }
      ])
    });

    _cartItems.update(prodId, (value) => cartModel(id: value.id, prodid: prodId , quantity: value.quantity -1));
    notifyListeners();
  }
  Future<void> IncreaseQuantityByOne({required String prodId,required int quantity})
  async{
    final User? user = authInstance.currentUser;
    String _uid = user!.uid;
    await FirebaseFirestore.instance.collection('users').doc(_uid).update({
      'userCart': FieldValue.arrayUnion([{
        'productId': prodId,
        'quantity': quantity
      }
      ])
    });
    _cartItems.update(prodId, (value) => cartModel(id: value.id, prodid: prodId , quantity: value.quantity +1));
    notifyListeners();
  }
  Future<void> removeOneItem({required String prodId,required String cartId,required int quantity})async{
    final User? user = authInstance.currentUser;
    final _uid = user!.uid;
    await FirebaseFirestore.instance.collection('users').doc(_uid).update({
      'userCart':FieldValue.arrayRemove([
        {
          'cartId':cartId,
          'productId':prodId,
          'quantity':quantity,
        }
      ])
    });
    _cartItems.remove(prodId);
    await fetchCart();
    notifyListeners();
  }
  void clearCart() async{
    final User? user = authInstance.currentUser;
    final _uid = user!.uid;
    await FirebaseFirestore.instance.collection('users').doc(_uid).update({
      'userCart':[]
    });
    _cartItems.clear();
    notifyListeners();
  }
}