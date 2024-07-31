import 'package:flutter/material.dart';
import 'package:laza/Providers/gender_provider.dart';
import 'package:laza/Resources/Colors/Colors.dart';
import 'package:laza/Resources/MediaQuery/media_query.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/Widgets/GenderSelecter.dart';
import 'package:provider/provider.dart';
import '../../Resources/Paths/AssetsPath.dart';
import '../auth_screens/CreateAccountScreen.dart';

class GenderSelectionScreen extends StatefulWidget {
  const GenderSelectionScreen({super.key});

  @override
  State<GenderSelectionScreen> createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  @override
  Widget build(BuildContext context) {
   final fullHeight= getScreenSize(context).height;
   final fullWidth=  getScreenSize(context).width;
   final w  =getScreenSize(context).width*(1/375);
   final h= getScreenSize(context).height*(1/812);
   final gengerSelected = Provider.of<GenderProvider>(context);

    return  SafeArea(
            child: Scaffold(
        backgroundColor: MyColor.purple,
        body: Center(
          child: Stack(
            alignment: const Alignment(0, .95),
            children: [
              Container(
                height: double.maxFinite,
                  width: double.maxFinite,
                  child: Image.asset(PngImages.man,fit: BoxFit.contain, scale: 1,),),
              Container(
                height: 244,
                width: 345*w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyColor.white,
                ),
                child:  Padding(

                  padding:  const EdgeInsets.only(top: 8.0),
                  child: Column(
                    children: [
                      const Text('Look Good, Feel Good',style: TextStyle(
                        fontSize: 25 ,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600 ,
                        color: MyColor.textBlack,
                      ),),
                      const SizedBox(height: 10,),

                      const Text('Create your individual & unique style and\n look amazing everyday.',
                        textAlign:TextAlign.center,
                        style: TextStyle(
                        fontSize: 15 ,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400 ,
                        color: MyColor.textLight,
                      ),),
                      const SizedBox(height: 20,),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                        Genderselecter(lable: 'Man'),
                        Genderselecter(lable: 'Woman')
                      ],),
                      const SizedBox(height: 20,),
                      InkWell(
                        onTap: (){
                          NavigatorToReplace(context, Createaccountscreen());
                        },
                        child: const Text('Skip',
                          textAlign:TextAlign.center,
                          style: TextStyle(
                            fontSize: 17 ,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500 ,
                            color: MyColor.textLight,
                          ),),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
