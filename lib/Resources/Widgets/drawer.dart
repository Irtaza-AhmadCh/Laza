

import 'package:laza/Firebase/Auth/logout_auth.dart';
import 'package:provider/provider.dart';
import 'package:switcher_button/switcher_button.dart';

import '../../Providers/theme_provider.dart';
import '../../Veiw/auth_screens/login_screen.dart';
import '../../Veiw/cart_screen.dart';
import '../../Veiw/favirate_list_screen.dart';
import '../../Veiw/payment_screen.dart';
import '../NavigationBar/nav_bar.dart';
import '../Navigators/navigators.dart';
import '../Paths/AssetsPath.dart';
import '../Paths/imports.dart';
import 'drawerTile.dart';

drawer(context, double h){
  Drawer(
    backgroundColor: MyColor.white,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 45),
      child: ListView(

        children: [
          Column(
            children: [
              Row(
                children: [
                  InkWell(
                      focusColor: Colors.transparent,
                      splashColor:Colors.transparent,
                      hoverColor:Colors.transparent,
                      highlightColor:Colors.transparent,
                      onTap: (){
                        NavigatorPop(context);
                      },

                      child: Image.asset(PngImages.closeMenu,))
                ],
              ),
              const SizedBox(height: 30,),
              Row(
                children: [
                  Container(
                    height:45 ,
                    width: 45,
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColor.grey, ),
                      color: MyColor.grey,
                      shape: BoxShape.circle,
                      image: const DecorationImage(image: AssetImage(PngImages.shirt)),
                    ),
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Irtaza', style: TextStyle(
                        color: MyColor.textBlack,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600 ,
                        fontSize: 17,
                      ),),
                      Row(
                        children: [

                          Text('Verified Profile', style: TextStyle(
                            color: MyColor.textLight,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400 ,
                            fontSize: 13,
                          ),),
                          Icon(Icons.verified, color: MyColor.green, size: 15,)

                        ],
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 30,),
              DrawerTile(lable: 'Dark Mode', icon: PngImages.sun, modechanger:
              Consumer<ThemeProvider>(
                builder: ( context,  value,  child) {
                  return Container(
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
                        value: true,
                        onChange: (val) {
                          value.themeChanger(val);
                          print(val);
                        },
                      ));
                },),),
              // const DrawerTile(lable: 'Account Information', icon: PngImages.infoCircle, ),
              DrawerTile(
                  ontap: (){
                    navigatedFrom = '';
                    NavigatorTo(context, const CartScreen());
                  },
                  lable: 'Password', icon: PngImages.lock),
              DrawerTile(
                  ontap: (){
                    NavigatorTo(context, const CartScreen());
                  },
                  lable: 'Order', icon: PngImages.bag),
              DrawerTile(

                  ontap:(){   navigatedFrom = '';
                  NavigatorTo(context, const PaymentScreen());},lable: 'My Cards', icon: PngImages.card),
              DrawerTile(
                  ontap: (){
                    navigatedFrom = '';
                    NavigatorTo(context, const FavirateListScreen());
                  },
                  lable: 'Wishlist', icon: PngImages.heartpng),
              const DrawerTile(lable: 'Settings', icon: PngImages.setting),
            ],
          ),
          SizedBox(height: 144*h,),
          InkWell(
              onTap: (){
                NavigatorToReplace(context, const LoginScreen());
              },
              child:  SizedBox(
                height: 45,
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        logoutAuth(context);
                      },
                        child: Icon(Icons.logout, color: MyColor.red,)),
                    SizedBox(width: 5,),
                    Text('Logout' ,style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: MyColor.red,
                        fontFamily: 'Inter'
                    ),),
                  ],
                ),
              )
          )
        ],
      ),
    ),
  );
}