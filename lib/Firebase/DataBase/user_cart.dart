

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laza/Resources/NotificationMassage/ToastMassage.dart';
import 'package:provider/provider.dart';

import '../../Models/cart_item_model.dart';
import '../../Providers/bottom_buttom_provider.dart';

final dataBaseRef = FirebaseFirestore.instance.collection('Cart');
final _auth = FirebaseAuth.instance;

class Cart{
 static addCart(    context, {required String productId,required int qty,
   required int price,required String name,required String
   type,required String image}){
   print(productId);
   dataBaseRef.doc(_auth.currentUser!.uid).collection('CartItems').doc(productId).set({
     'ProductId' : productId,
     'QTY': qty,
     'Name': name,
     'Type':type,
     'Price':price,
     'Image':image,
   }).then((_){
     Provider.of<BottomButtomProvider>(context, listen:  false).endloading();
     Toastmassage.SuccessToast('Added to Cart');
   }).onError((error,stackTrace){
     Provider.of<BottomButtomProvider>(context, listen:  false).endloading();
     Toastmassage.ErrorToast(error);
   });
 }

  static removeCard(productId){
    dataBaseRef.doc(_auth.currentUser!.uid).collection('CartItems').doc(productId).delete().then((_){
      Toastmassage.SuccessToast('Removed from Cart');
    }).onError((error,stackTrace){
      Toastmassage.ErrorToast(error);
    });

  }

  static increaseCount(productId,int  quantity){
int  newQuantity=  quantity+1;
print('NEW ${newQuantity}');
    dataBaseRef.doc(_auth.currentUser!.uid).collection('CartItems').doc(productId).update({
      'QTY': newQuantity,
    }).then((_){
      Toastmassage.SuccessToast('Increased');
    }).onError((error,stackTrace){
      Toastmassage.ErrorToast(error);
    });

  }

  static decreaseCount(productId ,int  quantity){
int  newQuantity =  quantity-1;
print('NEW ${newQuantity}');
dataBaseRef.doc(_auth.currentUser!.uid).collection('CartItems').doc(productId).update({
      'QTY': newQuantity,
    }).then((_){
Toastmassage.SuccessToast('Decreased');
    }).onError((error,stackTrace){
      Toastmassage.ErrorToast(error);
    });

  }


  static clearCart(){
    dataBaseRef.doc(_auth.currentUser!.uid).delete().then((_){
      Toastmassage.SuccessToast('Checkout Successful');
    }).onError((error,stackTrace){
      Toastmassage.ErrorToast(error);
    });;
 }


}