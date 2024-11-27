import 'package:flutter/material.dart';
import 'package:laza/Firebase/Auth/google_auth.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/Widgets/account_creating_bottons.dart';
import 'package:laza/Veiw/auth_screens/login_screen.dart';
import '../../Resources/MediaQuery/media_query.dart';
import '../../Resources/Paths/AssetsPath.dart';
import 'package:laza/Resources/Paths/imports.dart';
import 'SignIn.dart';

class Createaccountscreen extends StatefulWidget {
  const Createaccountscreen({super.key});

  @override
  State<Createaccountscreen> createState() => _CreateaccountscreenState();
}

class _CreateaccountscreenState extends State<Createaccountscreen> {


  @override
  Widget build(BuildContext context) {
    final fullHeight= getScreenSize(context).height;
    final fullWidth=  getScreenSize(context).width;
    final w  =getScreenSize(context).width*(1/375);
    final h= getScreenSize(context).height*(1/812);
    return  SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.white,
        body: Padding(
          padding:  EdgeInsets.only( top: 45 *h ),
          child: SingleChildScrollView(
            child: Column(

              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20,),
                  child: Column(
                    children: [
                     const    Text("Let’s Get Started",
                    textAlign:  TextAlign.center,
                    style: const TextStyle(
                      fontWeight:FontWeight.w600 ,
                      fontSize:28 ,
                      fontFamily: 'Inter',
                      color: MyColor.textBlack,
                    ),),
                      SizedBox(height: 185 *h ),
                       AccountCreatingBottons(lable: 'Facebook', color: Color(0xff4267B2),
                          icon: Images.facebook, ontap: () {  },),
                       SizedBox(height: 10 *h ,),
                       AccountCreatingBottons(lable: 'Twitter', color: Color(0xff1DA1F2), icon: Images.twitter, ontap: () {  },),
                       SizedBox(height: 10 *h ,),
                       AccountCreatingBottons(lable: 'Google', color: Color(0xffEA4335), icon: Images.google, ontap: () {  GoogleAuth.googleAuth();},),
                      SizedBox(height: 204 *h ,),
                      GestureDetector(
                        onTap: (){
                          NavigatorTo(context, LoginScreen());
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                             mainAxisSize: MainAxisSize.min,
                             children: [
                                Text('Already have an account? ', style: TextStyle(
                                 fontWeight:FontWeight.w400 ,
                                 fontSize:15 ,
                                 fontFamily: 'Inter',
                                 color: MyColor.textLight,
                               ),),
                                Text('Signin', style: TextStyle(
                                 fontWeight:FontWeight.w600 ,
                                 fontSize:15 ,
                                 fontFamily: 'Inter',
                                 color: MyColor.textBlack,
                               ),),
                             ],
                           ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar:  BottomButtons(lable: 'Create an Account', ontap: (){
          NavigatorTo(context, const SignInScreen());
        }) ,
      ),

    );
  }
}
