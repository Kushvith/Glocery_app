import 'package:flutter/cupertino.dart';
import 'package:flutter_proj/models/cartModel.dart';
import 'package:flutter_proj/models/whilist_model.dart';

class WhilistProvider extends ChangeNotifier{
  Map<String,whislistModel> _whislistItems = {};
  Map<String,whislistModel> get getWhislistItems{
    return _whislistItems;
  }
  void addProductToList({
    required String productId,
  })
  {
    if(getWhislistItems.containsKey(productId)){
      _whislistItems.remove(productId);

    }
    else{
      _whislistItems.putIfAbsent(productId, () =>
          whislistModel(id: DateTime.now().toString(), prodid: productId ));
    }

    notifyListeners();
  }

  void removeOneItem(String prodId){
    _whislistItems.remove(prodId);
    notifyListeners();
  }
  void clearCart(){
    _whislistItems.clear();
    notifyListeners();
  }
}