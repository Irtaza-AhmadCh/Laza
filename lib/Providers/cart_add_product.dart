import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laza/Models/cart_item_model.dart';
import 'package:laza/Models/cart_product_model.dart';
import '../Firebase/DataBase/user_cart.dart';

class CartAddProductProvider with ChangeNotifier {


  addToCart(
  context, {required String productId, required int qty, required int price, required String name, required String type, required String image}) {
    Cart.addCart(
      context,
        productId: productId,
        qty: qty,
        price: price,
        name: name,
        type: type,
        image: image);
    notifyListeners();
  }


  List<CartItemModel> cartList = [];

  Future getCart() async {

    List<CartItemModel> cartDataList = [];
    QuerySnapshot<Map<String, dynamic>> dataRef = await FirebaseFirestore
        .instance.collection('Cart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('CartItems')
        .get();

    dataRef.docs.forEach((element) {
      CartItemModel modaldata = CartItemModel(
          productId: element.get('ProductId'),
          quantity: element.get('QTY'),
          image: element.get('Image'),
          name: element.get('Name'),
          type: element.get('Type'),
          price: element.get('Price'));
      cartDataList.add(modaldata);
    });
    cartList = cartDataList;
    notifyListeners();
  }

  get cartdata {
    print('data');
    return cartList;
  }


  cartSubTotal(){
  double  subTotal =0.0;
    cartList.forEach((element){

     subTotal += element.price * element.quantity;

    });
    return subTotal;
  }


  incriment(productId, quantity){
    Cart.increaseCount(productId, quantity);
    notifyListeners();
  }

  decriment(productId, quantity){
    Cart.decreaseCount(productId, quantity);
    notifyListeners();
  }

}