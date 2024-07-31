import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Veiw/home_screen.dart';

import '../../Resources/NotificationMassage/ToastMassage.dart';

final _auth = FirebaseAuth.instance;

loginAuth(email,password, context){
  _auth.signInWithEmailAndPassword(email: email, password: password).then(
          (_){
        Toastmassage.SuccessToast('LogIn SuccessFully');
        NavigatorToReplace(context, HomeScreen());

      }
  ).onError((error, stackTrace){
    Toastmassage.ErrorToast(error.toString());
  });
}