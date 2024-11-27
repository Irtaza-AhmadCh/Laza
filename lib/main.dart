import 'package:flutter/material.dart';
import 'package:laza/Firebase/DataBase/user_cart.dart';
import 'package:laza/Providers/addressProvider.dart';
import 'package:laza/Providers/bottom_buttom_provider.dart';
import 'package:laza/Providers/card-type-provider.dart';
import 'package:laza/Providers/cart_product_count_provider.dart';
import 'package:laza/Providers/gender_provider.dart';
import 'package:laza/Providers/home-provider.dart';
import 'package:laza/Providers/product_detail_provider.dart';
import 'package:laza/Providers/reviw_provider.dart';
import 'package:laza/Providers/size_selector_provider.dart';
import 'package:laza/Providers/textfeild_tick_provider.dart';
import 'package:laza/Providers/theme_provider.dart';
import 'package:laza/Providers/wishList_provider.dart';
import 'package:laza/Resources/Colors/Colors.dart';
import 'package:laza/Resources/NavigationBar/nav_bar.dart';
import 'package:laza/Veiw/all_brands.dart';
import 'package:laza/Veiw/auth_screens/CreateAccountScreen.dart';
import 'package:laza/Veiw/auth_screens/SignIn.dart';
import 'package:laza/Veiw/shoping_screen/add_review_screen.dart';
import 'package:laza/Veiw/shoping_screen/address_screen.dart';
import 'package:laza/Veiw/shoping_screen/all_arrival_screen.dart';
import 'package:laza/Veiw/cart_screen.dart';
import 'package:laza/Veiw/auth_screens/confirm_password_screen.dart';
import 'package:laza/Veiw/shoping_screen/confrim_order_screen.dart';
import 'package:laza/Veiw/auth_screens/forget_password_screen.dart';
import 'package:laza/Veiw/auth_screens/login_screen.dart';
import 'package:laza/Veiw/payment_screen.dart';
import 'package:laza/Veiw/product_detail_screen.dart';
import 'package:laza/Veiw/reviews_screen.dart';
import 'package:provider/provider.dart';

import 'Providers/cart_add_product.dart';
import 'Providers/cart_item_delete_provider.dart';
import 'Providers/search_provider.dart';
import 'Providers/star_slider_provider.dart';
import 'Providers/timer_provider.dart';
import 'Veiw/SplashScreen.dart';
import 'Veiw/auth_screens/choose_new_password.dart';
import 'Veiw/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> GenderProvider()),
      ChangeNotifierProvider(create: (_)=> TimerProvider()),
      ChangeNotifierProvider(create: (_)=> ThemeProvider()),
      ChangeNotifierProvider(create: (_)=> ProductDetailProvider()),
      ChangeNotifierProvider(create: (_)=> SizeSelectorProvider()),
      ChangeNotifierProvider(create: (_)=> StarSliderProvider()),
      ChangeNotifierProvider(create: (_)=> CardTypeProvider()),
      ChangeNotifierProvider(create: (_)=> CartItemDeleteProvider()),
      ChangeNotifierProvider(create: (_)=> CartProductcountProvider()),
      ChangeNotifierProvider(create: (_)=> TextfeildTickProvider()),
      ChangeNotifierProvider(create: (_)=> WishlistProvider()),
      ChangeNotifierProvider(create: (_)=> Addressprovider()),
      ChangeNotifierProvider(create: (_)=> HomeScreenProvvider()),
      ChangeNotifierProvider(create: (_)=> CartAddProductProvider()),
      // ChangeNotifierProvider(create: (_)=> ReviewProvider()),
      ChangeNotifierProvider(create: (_)=> SearchProvider()),
      ChangeNotifierProvider(create: (_)=> BottomButtomProvider()),
    ],
    child: Builder(
        builder: (context){
          return  MaterialApp(
            themeMode: ThemeMode.light,
            darkTheme: ThemeData(
                appBarTheme: AppBarTheme(

                  foregroundColor: MyColor.textBlack,
                ),

              brightness: Brightness.dark
            ),
            theme: ThemeData(

                focusColor: Colors.transparent,
                splashColor:Colors.transparent,
                hoverColor:Colors.transparent,
                highlightColor:Colors.transparent,
                appBarTheme: AppBarTheme(
                  backgroundColor: MyColor.white,
                  foregroundColor: MyColor.white,
                  surfaceTintColor: MyColor.white
                ),
                scaffoldBackgroundColor: MyColor.white,
                brightness: Brightness.light
            ),

            home: Splashscreen()
          );
        },
    ),);


  }
}

