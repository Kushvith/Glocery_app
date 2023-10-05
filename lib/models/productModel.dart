import 'package:flutter/cupertino.dart';

class ProductModel extends ChangeNotifier {
  final String title, id, productCategoryName, imageUrl;
  final double price, salePrice;
  final bool isOnSale, isPiece;

  ProductModel(
      {required this.title,
      required this.id,
      required this.productCategoryName,
      required this.imageUrl,
      required this.price,
      required this.salePrice,
      required this.isOnSale,
      required this.isPiece});
}
