import 'package:flutter/cupertino.dart';

class cartModel extends ChangeNotifier{
  final String id,prodid;
  final int quantity;

  cartModel({required this.id, required this.prodid, required this.quantity});
}