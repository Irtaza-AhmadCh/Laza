import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laza/Models/cart_item_model.dart';

class CartProductcountProvider extends ChangeNotifier{
  int _itemCount = 1;
  List<int> _listitemcount = [];
  int get itemCount => _itemCount;

  increaseCount(position){
    cartItems[position].quantity++;
    notifyListeners();
  }
  decreaseCount(position){
    if(cartItems[position].quantity >= 2){
      cartItems[position].quantity--;
    notifyListeners();
  }
  }
}