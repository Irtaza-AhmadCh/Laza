import 'package:flutter/material.dart';
import 'package:laza/Firebase/Auth/forget_password_auth.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/Paths/imports.dart';
import 'package:laza/Veiw/auth_screens/login_screen.dart';
import '../../Resources/MediaQuery/media_query.dart';
import '../../Resources/Paths/AssetsPath.dart';
import 'confirm_password_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final w = getScreenSize(context).width * (1 / 375);
    final h = getScreenSize(context).height * (1 / 812);

    return SafeArea(
      child:  Scaffold(
        body:  SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.only(top: 45*h, left: 20, right: 20),
                child: Column(
                  children: [
                   const TopHeader(lable: 'Forgot Password'),
                    SizedBox(height: 68*h,),
                    Container(
                      height: 166,
                        width: 255,
                        child: Image.asset(PngImages.forget,fit: BoxFit.fill, ),),
                    SizedBox(height: 80*h,),
                    MyTextField(
                      title: 'Email Address',
                      controller: emailController,
                      hintText: 'Enter Email',
                      onchange: () {},
                    ),
                    SizedBox(height: 165*h,),
                  const  Text('Please write your email to receive a\n confirmation code to set a new password. ',
                      textAlign: TextAlign.center,
                      style:  TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: MyColor.textLight,
                      ),),
                  ],
                ),
              ),SizedBox(height: 25*h,),

            ],
          ),
        ),
        bottomNavigationBar:  BottomButtons(lable: 'Confirm Mail', ontap: (){
         forgetPasswordAuth(emailController.text.toString(),context);
        }),
      ),
    );
  }
}
