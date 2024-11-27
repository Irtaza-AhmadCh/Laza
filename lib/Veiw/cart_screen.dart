import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laza/Providers/addressProvider.dart';
import 'package:laza/Providers/cart_add_product.dart';
import 'package:laza/Providers/cart_item_delete_provider.dart';
import 'package:laza/Models/cart_item_model.dart';
import 'package:laza/Providers/cart_product_count_provider.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/Widgets/cart_item.dart';
import 'package:laza/Resources/Widgets/reuseable_appbar.dart';
import 'package:laza/Veiw/shoping_screen/address_screen.dart';
import 'package:laza/Veiw/shoping_screen/confrim_order_screen.dart';
import 'package:laza/Veiw/payment_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../Firebase/DataBase/user_cart.dart';
import '../Resources/MediaQuery/media_query.dart';
import '../Resources/NavigationBar/nav_bar.dart';
import '../Resources/Paths/AssetsPath.dart';
import '../Resources/Paths/imports.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}
Future<DocumentSnapshot<Map<String, dynamic>>> UserData() async {
  final _auth = FirebaseAuth.instance;
  final String userId = _auth.currentUser!.uid.toString();
  final userRef = FirebaseFirestore.instance.collection('User').doc(userId);
  final docSnapshot = await userRef.get();
  return docSnapshot;
}

class _CartScreenState extends State<CartScreen> {

  
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserData();
  }

  @override
  Widget build(BuildContext context) {
    final w = getScreenSize(context).width * (1 / 375);
    final h = getScreenSize(context).height * (1 / 812);
    final cartProvider = Provider.of<CartAddProductProvider>(context ,listen: false);
    final cartDELProvider = Provider.of<CartItemDeleteProvider>(context ,listen: false);
    cartProvider.getCart();

    print('build');
    return SafeArea(
      child: Scaffold(
        appBar: appBar(context, title: 'Cart'),
        body:
            Consumer<CartAddProductProvider>(builder: (context, value, child) {
          return SingleChildScrollView(
              child:(value.cartList.isNotEmpty) ?  RefreshIndicator(
                onRefresh: () {
                  setState(() {
                    UserData();

                  });
                  return Future.delayed(Duration(seconds: 2));},
                child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                            future: UserData(),
                            builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                      futuresnapshot) {



                            if (futuresnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: LoadingAnimationWidget.stretchedDots(
                          color: MyColor.purple, size: 60));
                }  else if(futuresnapshot.hasError) {
                return const Center(
                    child: Text(
                      'No Data Found',
                      style: TextStyle(
                          color: MyColor.textBlack,
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          fontFamily: 'Inter'),
                    ));

                            } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                             SizedBox(
                                    // height: getScreenSize(context).height / 2,
                                    child:Consumer<CartAddProductProvider>(
                                        builder: (BuildContext context, CartAddProductProvider vlue, Widget? child) {
                                          print("cart data ${value.cartdata}");
                                          print("cart list ${value.cartList}");
                                          return ListView.builder(
                                            itemCount: value.cartList.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {

                                              List<CartItemModel> data =  value.cartdata;
                                            print('image ${data[index].image}');
                                              return    CartItemTile(
                                                        lable: data[index].name,
                                                        price:data[index].price.toInt(),
                                                        quantity: data[index].quantity,
                                                        onDelete: () {},
                                                        position: index,
                                                        ProjectId: data[index].productId,
                                                        imagePath: data[index].image);
                                                  });

                                            },
                                          ),
                                ),
                            SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Delivery Address',
                                  style: TextStyle(
                                      color: MyColor.textBlack,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                      fontFamily: 'Inter'),
                                ),
                                InkWell(
                                    onTap: () {
                                      NavigatorTo(context, const AddressScreen());
                                    },
                                    child: const Icon(
                                      Icons.navigate_next_rounded,
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Consumer<Addressprovider>(
                                builder: (context, value, child) {
                              if (futuresnapshot.data!.data()!['AddressDetail'] !=
                                  null) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: MyColor.white,
                                              image: const DecorationImage(
                                                  image:
                                                      AssetImage(PngImages.map),
                                                  fit: BoxFit.fill)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Container(
                                              height: 20,
                                              width: 20,
                                              decoration: const BoxDecoration(
                                                  color: Color(0xffFF7043),
                                                  shape: BoxShape.circle),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: SvgPicture.asset(
                                                  Images.location,
                                                  fit: BoxFit.fill,
                                                  height: 10,
                                                  width: 8,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 14,
                                        ),
                                        Consumer(
                                          builder: (BuildContext context, value,
                                              Widget? child) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 202 * w,
                                                  child: Text(
                                                    futuresnapshot.data!.data()![
                                                            'AddressDetail'][0]
                                                        ['address'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                      color: MyColor.textBlack,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 15,
                                                      fontFamily: "Inter",
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 207 * w,
                                                  child: Text(
                                                    futuresnapshot.data!.data()![
                                                            'AddressDetail'][0]['city'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: const TextStyle(
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
                                    const Icon(
                                      Icons.check_circle,
                                      color: MyColor.green,
                                    )
                                  ],
                                );
                              } else {
                                return const Text(
                                  'No Address Added',
                                  style: TextStyle(
                                      color: MyColor.textBlack,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                      fontFamily: 'Inter'),
                                );
                              }
                            }),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Payment Method',
                                    style: TextStyle(
                                        color: MyColor.textBlack,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17,
                                        fontFamily: 'Inter'),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        navigatedFrom = '';
                                        NavigatorTo(context, const PaymentScreen());
                                      },
                                      child: const Icon(
                                        Icons.navigate_next_rounded,
                                      ))
                                ]),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: (futuresnapshot.data!.data()!['Cards'] != null)
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: MyColor.grey,
                                                  ),
                                                  child: SvgPicture.asset(
                                                      Images.vise),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 14,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 202 * w,
                                                  child: Text(
                                                    futuresnapshot.data!.data()!['Cards'][selectedIndex]
                                                        ['cardType'],
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                      color: MyColor.textBlack,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 15,
                                                      fontFamily: "Inter",
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 207 * w,
                                                  child: Text(
                                                    ' ${futuresnapshot.data!.data()!['Cards'][selectedIndex]['cardNo'].toString().replaceRange(0, 6, '******')}',
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                      color: MyColor.textLight,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 13,
                                                      fontFamily: "Inter",
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const Icon(
                                          Icons.check_circle,
                                          color: MyColor.green,
                                        )
                                      ],
                                    )
                                  : const Text(
                                      'No Card Added',
                                      style: TextStyle(
                                          color: MyColor.textBlack,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17,
                                          fontFamily: 'Inter'),
                                    ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Consumer<CartAddProductProvider>(
                              builder: (BuildContext context,  value, Widget? child) {
                                return   Column(
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
                                                fontFamily: 'Inter'),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 13,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Subtotal',
                                            style: TextStyle(
                                                color: MyColor.textLight,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                                fontFamily: 'Inter'),
                                          ),
                                          Text(
                                            '\$${value.cartSubTotal()}',
                                            style: TextStyle(
                                                color: MyColor.textBlack,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                fontFamily: 'Inter'),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 13,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Shipping cost',
                                            style: TextStyle(
                                                color: MyColor.textLight,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                                fontFamily: 'Inter'),
                                          ),
                                          Text(
                                            '\$10',
                                            style: TextStyle(
                                                color: MyColor.textBlack,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                fontFamily: 'Inter'),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 13,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Total',
                                            style: TextStyle(
                                                color: MyColor.textLight,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                                fontFamily: 'Inter'),
                                          ),
                                          Text(
                                            '\$${value.cartSubTotal()+10}',
                                            style: TextStyle(
                                                color: MyColor.textBlack,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                fontFamily: 'Inter'),
                                          ),
                                        ],
                                      ),
                                    ]);
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BottomButtons(
                          lable: 'Checkout',
                          ontap: () {
                            Cart.clearCart();
                            NavigatorTo(context, const ConfirmOrderScreen());
                          })
                    ],
                  );
                }
                            },
                          ),
              ):
              Center(child: Container(
                  height: 300*w,width: 300*w,
                  child: Lottie.asset(
                      Animations.emptybox, repeat: true,fit: BoxFit.cover))));
        }),
      ),
    );
  }
}
