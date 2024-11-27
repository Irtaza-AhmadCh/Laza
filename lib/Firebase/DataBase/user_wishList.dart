import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laza/Resources/NotificationMassage/ToastMassage.dart';

class UserWishlist{
 static addWishList({productId, Producttype,Productname,Productbrand,ProductimagePath, Size,Productdescription,ProductReviews,Productprice}){
   final dataRef= FirebaseFirestore.instance.collection('Wishlist')
       .doc(FirebaseAuth.instance.currentUser!.uid).collection('WishlistItem');
   dataRef.doc(productId).set({
   'ProductId': productId,
  'Producttype': Producttype,
   'Productname':Productname,
   'Productbrand':Productbrand,
  'ProductimagePath':ProductimagePath,
 'Size':Size,
 'Productdescription':Productdescription,
'ProductReviews':ProductReviews,
   'Productprice':Productprice,
     'Status': true,
  }).then((_){
     Toastmassage.SuccessToast('Added to WishList');
   }).onError((error,stackTrace){
     Toastmassage.ErrorToast(error);
   });
  }

 static removeWishList(productId){
   final dataRef= FirebaseFirestore.instance.collection('Wishlist').doc(FirebaseAuth.instance.currentUser!.uid).collection('WishlistItem');
   dataRef.doc(productId).delete().then((_){
     Toastmassage.SuccessToast('Removed form WishList');
   }).onError((error,stackTrace){
     Toastmassage.ErrorToast(error);
   });
 }


}