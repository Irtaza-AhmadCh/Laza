import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laza/Firebase/DataBase/user_cart.dart';
import 'package:laza/Models/cart_item_model.dart';

import '../Resources/NotificationMassage/ToastMassage.dart';

class CartProductcountProvider extends ChangeNotifier{
  int _itemCount = 1;
  List<int> _listitemcount = [];
  int get itemCount => _itemCount;

  final dataBaseRef = FirebaseFirestore.instance.collection('User');
  final _auth = FirebaseAuth.instance;

  increaseCount( {productId, quantity}){

Cart.increaseCount(productId, quantity);
    notifyListeners();
  }


  decreaseCount( {productId, quantity}){
    if(quantity >1 ){
     Cart.decreaseCount(productId, quantity);
    notifyListeners();
  }
  }}
