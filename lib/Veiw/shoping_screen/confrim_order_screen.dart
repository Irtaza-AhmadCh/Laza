import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/Paths/AssetsPath.dart';
import 'package:laza/Resources/Widgets/reuseable_appbar.dart';
import 'package:laza/Veiw/cart_screen.dart';

import '../../Resources/MediaQuery/media_query.dart';
import '../../Resources/NavigationBar/nav_bar.dart';
import '../../Resources/Paths/imports.dart';

class ConfirmOrderScreen extends StatefulWidget {
  const ConfirmOrderScreen({super.key});

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  @override
  Widget build(BuildContext context) {
    final w = getScreenSize(context).width * (1 / 375);
    final h = getScreenSize(context).height * (1 / 812);

    return  SafeArea(child: Scaffold(
      appBar: appBar(context, title: ''),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(

                    alignment: Alignment(0, -.68),
                    children: [
                  Container(
                    child: Image.asset(
                        PngImages.confirmOrderBack),
                  ),
                  Image.asset(PngImages.confirmOrderMoble, fit: BoxFit.cover,)
                ]
                   ),
                const SizedBox(height: 40,),
                const Text('Order Confirmed!', style: TextStyle(
                  color: MyColor.textBlack ,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 28,
                ),),
                const Text('Your order has been confirmed, we will send\n you confirmation email shortly.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  color: MyColor.textLight,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),),
                SizedBox(height: 105,),
                InkWell(
                  onTap: (){
                    NavigatorToReplace(context, CartScreen());
                  },
                  child: Container(
                    height:50 ,
                    width:335*w,
                    decoration: BoxDecoration(
                      color: MyColor.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Go to Orders',
                        style: TextStyle(
                          color: MyColor.textLight,
                          fontSize: 17,
                          fontWeight:  FontWeight.w400,
                          fontFamily: 'Inter' ,
                        ),
                      ),
                    ),
                                    ),
                ),
                SizedBox(height: 25,),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomButtons(lable: 'Continue Shopping',ontap: (){
        NavigatorToReplace(context, NavBar());
      },),
    ),

    );
  }
}
