import 'package:laza/Providers/cart_item_delete_provider.dart';
import 'package:laza/Models/cart_item_model.dart';
import 'package:laza/Providers/cart_product_count_provider.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/Widgets/cart_item.dart';
import 'package:laza/Resources/Widgets/reuseable_appbar.dart';
import 'package:laza/Veiw/shoping_screen/address_screen.dart';
import 'package:laza/Veiw/shoping_screen/confrim_order_screen.dart';
import 'package:laza/Veiw/payment_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../Models/choose_brand_model.dart';
import '../Models/new_arrival_model.dart';
import '../Resources/MediaQuery/media_query.dart';
import '../Resources/Paths/AssetsPath.dart';
import '../Resources/Paths/imports.dart';
import '../Resources/Widgets/choose_brand.dart';
import '../Resources/Widgets/new_arrival_tile.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final w  =getScreenSize(context).width*(1/375);
    final h= getScreenSize(context).height*(1/812);
print('build');
    return SafeArea(
      child: Scaffold(
        appBar: appBar(context, title: 'Cart'),
        body:Consumer<CartItemDeleteProvider>(
    builder: (context,value, child){
    return (cartItems.length ==0 )?
    Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Center(child: Container(
        height: 300*w,width: 300*w,
                child: Lottie.asset(
              Animations.emptybox, repeat: true,fit: BoxFit.cover)), ),

          ],
        ):SingleChildScrollView(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      child: Consumer<CartItemDeleteProvider>(
                        builder: (context,value, child){
                          return SizedBox(
                            height: getScreenSize(context).height/2,
                            child: ListView.builder(
                                itemCount: cartItems.length,
                                shrinkWrap: true,
                                itemBuilder: (context,index){

                                  return   Consumer<CartProductcountProvider>(
                                  builder: (context,value, child) {
                                    return CartItemTile(
                                        lable: cartItems[index].desciption,
                                        price: cartItems[index].price,
                                        quantity: cartItems[index].quantity,
                                        onDelete: () {

                                        },
                                        position: index,
                                        imagePath: cartItems[index].imagePath);
                                  });
                                }),
                          );
                        },

                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Delivery Address',
                          style: TextStyle(
                              color: MyColor.textBlack,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                              fontFamily: 'Inter'
                          ),
                        ),
                        IconButton(onPressed: (){
                          NavigatorTo(context, AddressScreen());
                        },icon: const  Icon(Icons.navigate_next_rounded,))

                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 50 ,
                              width: 50,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                  color:MyColor.white,
                                  image: const DecorationImage(image: AssetImage(PngImages.shirt), fit: BoxFit.fill)
                              ),

                            ),
                            const SizedBox(width: 14,),
                            Consumer(
                              builder: (BuildContext context, value, Widget? child) {
                                return  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:202*w,
                                      child:  const Text(
                                        'Chhatak, Sunamgonj 12/8AB',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: MyColor.textBlack,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          fontFamily: "Inter",
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      width:207*w,
                                      child:  const Text(
                                        'Sylhet',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: MyColor.textLight,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                          fontFamily: "Inter",
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },

                            ),
                          ],
                        ),
                        const Icon(Icons.check_circle,  color: MyColor.green,)
                      ],
                    ),
                    const SizedBox(height: 25,),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Payment Method',
                            style: TextStyle(
                                color: MyColor.textBlack,
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                fontFamily: 'Inter'
                            ),
                          ),
                          IconButton(onPressed: (){
                            NavigatorTo(context, PaymentScreen());
                          },icon: Icon(Icons.navigate_next_rounded,))
                        ]
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 50 ,
                                  width: 50,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                    color:MyColor.grey,),
                                  child: SvgPicture.asset(Images.vise),),]

                          ),
                          const SizedBox(width: 14,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 202*w,
                                child:  const Text(
                                  'Visa Classic',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: MyColor.textBlack,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    fontFamily: "Inter",
                                  ),
                                ),
                              ),

                              SizedBox(
                                width:207*w,
                                child:  const Text(
                                  '**** 7690',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: MyColor.textLight,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    fontFamily: "Inter",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Icon(Icons.check_circle,  color: MyColor.green,)
                        ],
                      ),
                    ),
                    const SizedBox(height: 25,),
                    const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Order Info',
                                style: TextStyle(
                                    color: MyColor.textBlack,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                    fontFamily: 'Inter'
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 13,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text(
                                'Subtotal',
                                style: TextStyle(
                                    color: MyColor.textLight,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    fontFamily: 'Inter'
                                ),
                              ),
                              Text(
                                '\$100',
                                style: TextStyle(
                                    color: MyColor.textBlack,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    fontFamily: 'Inter'
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 13,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Shipping cost',
                                style: TextStyle(
                                    color: MyColor.textLight,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    fontFamily: 'Inter'
                                ),
                              ),
                              Text(
                                '\$10',
                                style: TextStyle(
                                    color: MyColor.textBlack,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    fontFamily: 'Inter'
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 13,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(
                                    color: MyColor.textLight,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    fontFamily: 'Inter'
                                ),
                              ),
                              Text(
                                '\$110',
                                style: TextStyle(
                                    color: MyColor.textBlack,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    fontFamily: 'Inter'
                                ),
                              ),
                            ],
                          ),

                        ]
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              BottomButtons(lable: 'Checkout', ontap: (){
                NavigatorTo(context, const ConfirmOrderScreen());})
            ],
          )

            );}),

        ),
    );

    }
    }