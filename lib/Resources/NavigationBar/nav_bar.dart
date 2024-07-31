import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laza/Resources/Colors/Colors.dart';
import 'package:laza/Resources/Paths/AssetsPath.dart';
import 'package:laza/Veiw/cart_screen.dart';
import 'package:laza/Veiw/favirate_list_screen.dart';
import 'package:laza/Veiw/home_screen.dart';

import '../../Veiw/payment_screen.dart';
import '../Paths/imports.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

var navigatedFrom ;
class _NavBarState extends State<NavBar> {
int  _selectedIndex = 0;
List screens =[
  HomeScreen(),
  FavirateListScreen(),
  CartScreen(),
  PaymentScreen(),
];
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: ()async{
       await SystemNavigator.pop();
        return false ;
      },
      child: Scaffold(
        body: screens[_selectedIndex],
        bottomNavigationBar:FlashyTabBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          navigatedFrom = 'navBar';
          _selectedIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            icon: SvgPicture.asset(Images.bottomHome),
            title: const Text('Home', style: TextStyle(
              color: MyColor.purple ,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),),
            activeColor: MyColor.purple,
            inactiveColor: MyColor.grey,
          ),
          FlashyTabBarItem(
            icon:  SvgPicture.asset(Images.heart),
            title: const Text('Wishlist', style: TextStyle(
      color: MyColor.purple ,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      fontSize: 11,
      ),),
      activeColor: MyColor.purple,
      inactiveColor: MyColor.grey,),

          FlashyTabBarItem(
            icon: SvgPicture.asset(Images.bottomCart),
            title: const Text('Cart', style: TextStyle(
      color: MyColor.purple ,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      fontSize: 11,
      ),),
      activeColor: MyColor.purple,
      inactiveColor: MyColor.grey,),
          FlashyTabBarItem(
            icon: SvgPicture.asset(Images.bottomPayment),
            title: const Text('Payment', style: TextStyle(
              color: MyColor.purple ,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),),
          activeColor: MyColor.purple,
          inactiveColor: MyColor.grey,),

        ],
      ),
      ),
    );
  }
}
