import 'package:flutter/material.dart';
import 'package:laza/Firebase/Auth/login_auth.dart';
import 'package:laza/Providers/textfeild_tick_provider.dart';
import 'package:laza/Resources/Colors/Colors.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/Paths/imports.dart';
import 'package:laza/Resources/Widgets/TextFields.dart';
import 'package:laza/Resources/Widgets/bottom_button.dart';
import 'package:laza/Resources/Widgets/top_back_and-text.dart';
import 'package:laza/Veiw/auth_screens/forget_password_screen.dart';
import 'package:provider/provider.dart';
import 'package:switcher_button/switcher_button.dart';

import '../../Resources/MediaQuery/media_query.dart';
import '../../Resources/NavigationBar/nav_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool val = true;
  bool valid = true;
  @override
  Widget build(BuildContext context) {
    final w = getScreenSize(context).width * (1 / 375);
    final h = getScreenSize(context).height * (1 / 812);
    final provider = Provider.of<TextfeildTickProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 45),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween ,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      const TopHeader(lable: 'Welcome'),
                      SizedBox(
                        height: 5 * h,
                      ),
                      const Text(
                        'Please enter your data to continue',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: MyColor.textLight,
                        ),
                      ),
                      SizedBox(
                        height: 163 * h,
                      ),
                      Consumer<TextfeildTickProvider>(
                        builder: (BuildContext context, value, Widget? child) {
                          return    MyTextField(
                            title: 'Email Address',
                            fieldType: 'email',
                            SuffixIcon: value.emailchanger(),
                            controller: emailController,
                            hintText: 'Enter Email',);

                        },

                      ),
                      SizedBox(
                        height: 20 * h,
                      ),
                      Consumer<TextfeildTickProvider>(
                        builder: (BuildContext context, value, Widget? child) {
                          return    MyTextField(
                            title: 'Password',
                            fieldType: 'password',
                            SuffixIcon: provider.passwordchanger(),
                            controller: passwordController,
                            hintText: 'Enter Password',);
                        },

                      ),
                      SizedBox(
                        height: 20 * h,
                      ),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: (){
            NavigatorTo(context, ForgetPasswordScreen());
          },
                            child: const Text(
                              'Forgot password?',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: MyColor.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40 * h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Remember me',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: MyColor.textBlack,
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: MyColor.textLight,
                                    width: 1,
                                  )),
                              height: 18,
                              width: 33,
                              child: SwitcherButton(
                                offColor: MyColor.white,
                                onColor: MyColor.green,
                                value: true,
                                onChange: (value) {},
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 107 * h,
                      ),
                      RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            text:'By connecting your account confirm that you agree with our ',
                            style:  TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: MyColor.textLight,
                            ),
                            children: const <TextSpan>[
                              TextSpan(text: 'Term and Condition', style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: MyColor.textBlack,
                              ),),

                            ],

                          )

                      ),
                    ],
                  ),
                ),


                SizedBox(
                  height: 25* h,
                ),

              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomButtons(lable: 'Login', ontap: () {
          // NavigatorTo(context, NavBar());
          loginAuth(emailController.text.toString(), passwordController.text.toString(), context);

        }) ,
      ),
    );
  }
}
