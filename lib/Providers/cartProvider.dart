import 'package:flutter/cupertino.dart';
import 'package:flutter_proj/models/cartModel.dart';

class cartProvider extends ChangeNotifier{
  Map<String,cartModel> _cartItems = {};
  Map<String,cartModel> get getCartItems{
    return _cartItems;
  }
  void addProductToList({
    required String productId,
    required int quantity
})
  {
    _cartItems.putIfAbsent(productId, () =>
    cartModel(id: DateTime.now().toString(), prodid: productId, quantity: quantity ));
    notifyListeners();
  }
  void ReduceQuantityByOne(String prodId)
  {
    _cartItems.update(prodId, (value) => cartModel(id: value.id, prodid: prodId , quantity: value.quantity -1));
    notifyListeners();
  }
  void IncreaseQuantityByOne(String prodId)
  {
    _cartItems.update(prodId, (value) => cartModel(id: value.id, prodid: prodId , quantity: value.quantity +1));
    notifyListeners();
  }
  void removeOneItem(String prodId){
    _cartItems.remove(prodId);
    notifyListeners();
  }
  void clearCart(){
    _cartItems.clear();
    notifyListeners();
  }
}