import 'package:firebase_auth/firebase_auth.dart';
import 'package:laza/Providers/bottom_buttom_provider.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Veiw/auth_screens/login_screen.dart';
import 'package:provider/provider.dart';
import '../../Resources/NotificationMassage/ToastMassage.dart';

final _auth = FirebaseAuth.instance;
forgetPasswordAuth(email, context){
  _auth.sendPasswordResetEmail(email: email).then(
          (_){
        Toastmassage.SuccessToast('Email has been Sent');
        Provider.of<BottomButtomProvider>(context, listen:  false).endloading();
        NavigatorToReplace(context, LoginScreen());

      }
  ).onError((error, stackTrace){
    Provider.of<BottomButtomProvider>(context, listen:  false).endloading();
    Toastmassage.ErrorToast(error.toString());
  });
}