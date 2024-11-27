

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laza/Resources/NotificationMassage/ToastMassage.dart';
User? user;
class GoogleAuth{

  static googleAuth(){
    final _auth = FirebaseAuth.instance;
    try{
      GoogleAuthProvider _googleAuthProvider =GoogleAuthProvider();

      _auth.signInWithProvider(_googleAuthProvider).then((val){
        FirebaseFirestore.instance.collection('User').doc( user!.uid).set({
         'Email': user!.email,
         'Id': user!.uid,
         'Name': user!.displayName,
         'ProfileImage': user!.photoURL,

        });
      });
    }catch(e){
      Toastmassage.ErrorToast(e);
    }
  }



}