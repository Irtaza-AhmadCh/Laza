import 'package:firebase_auth/firebase_auth.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Veiw/auth_screens/login_screen.dart';
import '../../Resources/NotificationMassage/ToastMassage.dart';

final _auth = FirebaseAuth.instance;
forgetPasswordAuth(email, context){
  _auth.sendPasswordResetEmail(email: email).then(
          (_){
        Toastmassage.SuccessToast('Email has been Sent');
        NavigatorToReplace(context, LoginScreen());

      }
  ).onError((error, stackTrace){
    Toastmassage.ErrorToast(error.toString());
  });
}