import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Veiw/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Providers/bottom_buttom_provider.dart';
import '../../Resources/NavigationBar/nav_bar.dart';
import '../../Resources/NotificationMassage/ToastMassage.dart';

final _auth = FirebaseAuth.instance;

loginAuth(email,password, context, val){
  _auth.signInWithEmailAndPassword(email: email, password: password).then(
          (_){
            Provider.of<BottomButtomProvider>(context, listen: false).endloading();
        Toastmassage.SuccessToast('LogIn SuccessFully');
        NavigatorToReplace(context, NavBar());
      }
  ).onError((error, stackTrace){
    Provider.of<BottomButtomProvider>(context, listen: false).endloading();
    Toastmassage.ErrorToast(error.toString());
  });
}