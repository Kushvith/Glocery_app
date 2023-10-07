

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_proj/consts/firebaseconnection.dart';
import 'package:flutter_proj/models/productModel.dart';

import '../models/orderModel.dart';

class orderProvider extends ChangeNotifier{
static List<OrderModel> _ordersList = [];
List<OrderModel> get getProducts{
return _ordersList;
}
Future<List<OrderModel>> FetchOrders() async{
  final User? user = authInstance.currentUser;
  if(user!=null) {
    final _uid = user!.uid;
    await FirebaseFirestore.instance.collection('users').doc(_uid).collection('orders')
        .get().then((QuerySnapshot orderSnapshot) {
      _ordersList = [];
      orderSnapshot.docs.forEach((element) {
        _ordersList.insert(0, OrderModel(orderId: element.get('orderId'),
            userId: element.get('userId'),
            productId: element.get('productId'),
            userName: element.get('userName'),
            imageUrl: element.get('imageUrl'),
            quantity: element.get('quantity').toString(),
            orderDate: element.get('orderDate'),
            price: element.get('price').toString()
        ));
      });
    });
  }
  print(_ordersList);
  notifyListeners();
  return _ordersList;
}
}