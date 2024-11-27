import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laza/Models/cart_item_model.dart';
import 'package:laza/Models/cart_product_model.dart';
import 'package:laza/Resources/NotificationMassage/ToastMassage.dart';
import '../Firebase/DataBase/user_cart.dart';
import '../Models/new_arrival_model.dart';

class HomeScreenProvvider with ChangeNotifier {


  List<NewArrivalModel> productList = [];
  List<NewArrivalModel> filteredProductList = [];


  Future getProduct() async {

try{
  List<NewArrivalModel> productDataList = [];
  QuerySnapshot<Map<String, dynamic>> dataRef = await FirebaseFirestore
      .instance.collection('Products')
      .get();

  dataRef.docs.forEach((element) {
    NewArrivalModel modaldata = NewArrivalModel(
        ProductimagePath: element.get('images'),
        Size: element.get('sizes'),
        Reviews: element.get('reviews'),
        Productdescription: element.get('description'),
        Productname: element.get('name'),
        Productprice: element.get('price'),
        Producttype: element.get('type'),
        ProductId: element.get('ProductId'),
        ProductBrand: element.get('brand'));

    productDataList.add(modaldata);
  });
  productList = productDataList;
  search('');
  print('ProductList $productList');
  notifyListeners();
}catch(e){
  Toastmassage.ErrorToast(e.toString());
}

  }

  search(String searchQuery){
    print('search');
    if(searchQuery.isNotEmpty){
      filteredProductList = productList.where((product){

        return
        product.Productdescription.toLowerCase().contains(searchQuery.toLowerCase())||
            product.Productname.toLowerCase().contains(searchQuery.toLowerCase()) || product.ProductBrand.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();

      notifyListeners();
      return filteredProductList;
    }
    else{
      filteredProductList = productList;
      notifyListeners();

      return filteredProductList;
    }
  }
   get productdata {
    print('data$filteredProductList');
    return filteredProductList;
  }


}