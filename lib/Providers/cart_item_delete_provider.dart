import 'package:flutter/cupertino.dart';

import '../Models/cart_item_model.dart';

class CartItemDeleteProvider extends ChangeNotifier{
  remover(position){
    cartItems.removeAt(position);
    notifyListeners();
  }
}