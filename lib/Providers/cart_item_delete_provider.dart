import 'package:flutter/cupertino.dart';

import '../Firebase/DataBase/user_cart.dart';
import '../Models/cart_item_model.dart';

class CartItemDeleteProvider extends ChangeNotifier{
  remover(productId){
    Cart.removeCard(productId);
    notifyListeners();
  }
}