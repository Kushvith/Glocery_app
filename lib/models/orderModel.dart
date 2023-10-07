import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderModel extends ChangeNotifier{
  final String orderId, userId, productId, userName, imageUrl, quantity,price;
  final Timestamp orderDate;

  OrderModel({required this.orderId, required this.userId, required this.productId, required this.userName,
      required this.imageUrl, required this.quantity, required this.orderDate,required this.price});
}
