import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../Resources/Navigators/navigators.dart';
import '../../Resources/NotificationMassage/ToastMassage.dart';
import '../../Veiw/auth_screens/login_screen.dart';

final _auth = FirebaseAuth.instance;

logoutAuth(context){
  _auth.signOut().then(
          (_)async{
        Toastmassage.SuccessToast('LogOut SuccessFully');
        NavigatorToReplace(context, LoginScreen());
        SharedPreferences sp = await  SharedPreferences.getInstance();
        sp.remove('rememberMe');

      }
  ).onError((error, stackTrace){
    Toastmassage.ErrorToast(error.toString());
  });
}