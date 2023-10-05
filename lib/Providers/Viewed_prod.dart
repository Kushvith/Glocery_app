import 'package:flutter/cupertino.dart';
import 'package:flutter_proj/models/cartModel.dart';
import 'package:flutter_proj/models/viewed_model.dart';
import 'package:flutter_proj/models/whilist_model.dart';

class ViewedProdProvider extends ChangeNotifier{
  Map<String,ViewedProdModel> _viewedProdItems = {};
  Map<String,ViewedProdModel> get getViewedProdItems{
    return _viewedProdItems;
  }
  void addProductToList({
    required String productId,
  })
  {
      _viewedProdItems.putIfAbsent(productId, () =>
          ViewedProdModel(id: DateTime.now().toString(),prodId: productId ));

    notifyListeners();
  }


  void clearHistory(){
    _viewedProdItems.clear();
    notifyListeners();
  }
}