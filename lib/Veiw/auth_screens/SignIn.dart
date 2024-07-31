import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laza/Firebase/Auth/signUp_auth.dart';
import 'package:laza/Providers/textfeild_tick_provider.dart';
import 'package:laza/Resources/Colors/Colors.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/Paths/imports.dart';
import 'package:laza/Resources/Widgets/TextFields.dart';
import 'package:laza/Resources/Widgets/bottom_button.dart';
import 'package:laza/Resources/Widgets/top_back_and-text.dart';
import 'package:provider/provider.dart';
import 'package:switcher_button/switcher_button.dart';

import '../../Resources/MediaQuery/media_query.dart';
import '../../Resources/NotificationMassage/ToastMassage.dart';
import 'login_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool val = true;

  File? _image ;
  final picker = ImagePicker();

  Future<void> pickImage() async{

  final  pickedImage =  await picker.pickImage(source: ImageSource.gallery);

  if(pickedImage != null){
    setState(() {
      _image = File(pickedImage.path);

      if(_image!= null){
        debugPrint('image is ${pickedImage.path}');

      }
    });
  }else{
   Toastmassage.ErrorToast('No Image is selected');
  }

  }

  @override
  Widget build(BuildContext context) {
    final w  =getScreenSize(context).width*(1/375);
    final h= getScreenSize(context).height*(1/812);
print('Build');
    return  SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween ,

            children: [
              Padding(
                padding:  const EdgeInsets.only(left: 20, right: 20,top: 45),
                child: Column(
                  children: [
                    const TopHeader(lable: 'Sign Up'),
                    SizedBox(height: 40*h,),
                  InkWell(
                    onTap: (){
                      pickImage();
                    },
                    child: Stack(
                      alignment: Alignment(.9, 1),
                      children:[
                        Container(
                          height: 100,
                          width: 100,
                          decoration:  BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: MyColor.textLight, width: 1.5 ),
                            color: MyColor.grey,
                          ),
                          child:Icon(Icons.person, color: MyColor.textLight,size: 80,)
                          // (_image ==null)?Icon(Icons.person, color: MyColor.textLight,size: 80,):
                          // Image.file(_image!),

                        ),
                        Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: MyColor.white

                            ),
                            child: Icon(Icons.add_circle_outlined, color: MyColor.purple,size: 30,)),



                      ]
                    ),
                  ),
                    SizedBox(height: 20*h,),
                  Consumer<TextfeildTickProvider>(
                    builder: (BuildContext context, TextfeildTickProvider value, Widget? child) {
                      return MyTextField(title: 'UserName',
                        controller:nameController,
                        SuffixIcon: value.namechanger(),
                        hintText: 'Enter Name', onchange: (){},
                        fieldType: 'name',
                      );
                    },

                  ),
                    SizedBox(height: 20*h,),
                Consumer<TextfeildTickProvider>(
                  builder: (BuildContext context, TextfeildTickProvider value, Widget? child) {
                    return    MyTextField(title: 'Password',
                      SuffixIcon: value.passwordchanger(),
fieldType: 'password',
                      controller:passwordController,
                      hintText: 'Enter Password',
                    );
                  },),

                    SizedBox(height: 20*h,),
                  Consumer<TextfeildTickProvider>(
                    builder: (BuildContext context, TextfeildTickProvider value, Widget? child) {
                      return    MyTextField(title: 'Email Address',
                        controller:emailController,
                        SuffixIcon: value.emailchanger(),
                        hintText: 'Enter Email', onchange: (){},
                        fieldType: 'email',
                      );
                    },),

                    SizedBox(height: 40*h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       const Text('Remember me', style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: MyColor.textBlack,
                        ), ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: MyColor.textLight,
                              width: 1,
                            )
                          ),
                          height: 18,
                          width: 33,
                          child: SwitcherButton(
                            offColor: MyColor.white,
                            onColor: MyColor.green,
                            value: true,
                            onChange: (value) {
                            },
                          )
                        )
                      ],
                    )
                  ],
                ),
              ),

            ],
          ),
        ),

        bottomNavigationBar:  BottomButtons(lable: 'Sign Up', ontap: (){
          // NavigatorTo(context, LoginScreen());
          signUp_auth(emailController.text.toString(), passwordController.text.toString(), context, nameController.text.toString(), _image);


        }),
      ),
    );
  }
}
