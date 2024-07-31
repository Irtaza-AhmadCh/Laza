import 'package:firebase_auth/firebase_auth.dart';


import '../../Resources/NotificationMassage/ToastMassage.dart';

final _auth = FirebaseAuth.instance;

logoutAuth(context){
  _auth.signOut().then(
          (_){
        Toastmassage.SuccessToast('LogOut SuccessFully');
        // NavigatorToReplace(context, LoginScreen());

      }
  ).onError((error, stackTrace){
    Toastmassage.ErrorToast(error.toString());
  });
}