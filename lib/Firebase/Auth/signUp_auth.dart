
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:laza/Firebase/DataBase/User_data/user_data.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/NotificationMassage/ScaffoldMassage.dart';
import 'package:laza/Resources/NotificationMassage/ToastMassage.dart';
import 'package:laza/Veiw/auth_screens/login_screen.dart';

final _auth = FirebaseAuth.instance;

signUp_auth(emailController, passwordController ,context ,nameController, image){
  _auth.createUserWithEmailAndPassword(email: emailController, password: passwordController).then(
      (_){
        Toastmassage.SuccessToast('Account Created SuccessFully');
        UserData(nameController, emailController, image);
        NavigatorTo(context, LoginScreen());

      }
  ).onError((error, stackTrace){
Toastmassage.ErrorToast(error.toString());
  });
}