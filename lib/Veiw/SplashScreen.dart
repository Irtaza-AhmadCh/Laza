import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Veiw/auth_screens/CreateAccountScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Resources/NavigationBar/nav_bar.dart';
import '../Resources/Paths/AssetsPath.dart';
import '../Resources/Paths/imports.dart';
import 'shoping_screen/gender_selection_screen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final _auth = FirebaseAuth.instance;
 bool? statu;

  rememberMe()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool status = sp.getBool('rememberMe') ?? false;
    statu = status;
    final _userstate = _auth.currentUser;
    print('cdcvv${_userstate != null } ');
    print('status $statu');

    if(statu == true) {

      if (_userstate != null) {
        Timer(Duration(seconds: 4),
                () {
              NavigatorToReplace(context, NavBar());
            });
      }
    }
    else {
      Timer(Duration(seconds: 4),
              () {
            NavigatorToReplace(context, Createaccountscreen());
          });
    };
  }

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
     rememberMe();

    }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: MyColor.purple,
      body: Center(

        child: SvgPicture.asset(Images.logo, height: 36, width: 59,),
      ),
    );

  }
}
