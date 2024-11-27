import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laza/Models/card_type_model.dart';
import 'package:laza/Providers/card-type-provider.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/Widgets/payment_container.dart';
import 'package:laza/Resources/Widgets/reuseable_appbar.dart';
import 'package:laza/Resources/Widgets/reuseable_textfield.dart';
import 'package:laza/Veiw/cart_screen.dart';
import 'package:laza/Veiw/shoping_screen/new_card_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:switcher_button/switcher_button.dart';
import '../Resources/MediaQuery/media_query.dart';
import '../Resources/NavigationBar/nav_bar.dart';
import '../Resources/Paths/AssetsPath.dart';
import '../Resources/Paths/imports.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

int selectedIndex = 0;
String statusOfCard = 'unsave';

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController cardOwnerController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardExpController = TextEditingController();
  TextEditingController cardCVVController = TextEditingController();

  Future<DocumentSnapshot<Map<String, dynamic>>> userData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final database =
        FirebaseFirestore.instance.collection('User').doc(uid.toString());
    final userdata = database.get();
    return userdata;
  }

  @override
  Widget build(BuildContext context) {
    final w = getScreenSize(context).width * (1 / 375);
    final h = getScreenSize(context).height * (1 / 812);

    return SafeArea(
        child: Scaffold(
      appBar: appBar(context, title: 'Payment'),
      body: RefreshIndicator(
        onRefresh: (){
          userData();
          return Future.delayed(Duration(seconds: 2));
        },
        child: SingleChildScrollView(
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: userData(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'No Data found',
                    style: TextStyle(
                      color: MyColor.textBlack,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: LoadingAnimationWidget.stretchedDots(
                        color: MyColor.purple, size: 60));
              } else {
                return (snapshot.data!.data()!['Cards'] != null)
                    ? Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(children: [
                                    Container(
                                      height: 185,
                                      child: Consumer<CardTypeProvider>(
                                        builder: (context, value, child) {
                                          return ListView.builder(
                                              itemCount: snapshot.data!
                                                  .data()!['Cards']
                                                  .length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(horizontal: 8),
                                                    child: InkWell(
                                                      onTap: () {
                                                        selectedIndex = index;
                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                        height: 185,
                                                        width: 300,
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: AssetImage(
                                                                PngImages
                                                                    .paymentCard),
                                                          ),
                                                          color: MyColor.grey,
                                                          border:
                                                              (selectedIndex ==
                                                                      index)
                                                                  ? Border.all(
                                                                      color: MyColor
                                                                          .textLight,
                                                                      width: 2,
                                                                    )
                                                                  : Border.all(
                                                                      color: MyColor
                                                                          .grey,
                                                                    ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          NavigatorTo(context, NewCardScreen());
                                        });
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 335 * w,
                                        decoration: BoxDecoration(
                                          color: Color(0xffF6F2FF),
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                            color: MyColor.purple,
                                            width: 1,
                                          ),
                                        ),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.add_box_outlined,
                                              color: MyColor.purple,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'Add new card',
                                              style: TextStyle(
                                                color: MyColor.purple,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Inter',
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    ReuseablePaymentcard(
                                        title: 'Card Owner',
                                        data: snapshot.data!.data()!['Cards']
                                            [selectedIndex]['name']),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    ReuseablePaymentcard(
                                        title: 'Card Number',
                                        data: snapshot.data!.data()!['Cards']
                                            [selectedIndex]['cardNo']),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width:
                                              getScreenSize(context).width / 2 -
                                                  28,
                                          child: ReuseablePaymentcard(
                                              title: 'Exp',
                                              data:
                                                  snapshot.data!.data()!['Cards']
                                                      [selectedIndex]['exp']),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        SizedBox(
                                          width:
                                              getScreenSize(context).width / 2 -
                                                  28,
                                          child: ReuseablePaymentcard(
                                              title: 'CVV',
                                              data:
                                                  snapshot.data!.data()!['Cards']
                                                      [selectedIndex]['cvv']),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     const Text(
                                    //       'Save as primary address',
                                    //       style: TextStyle(
                                    //         fontFamily: 'Inter',
                                    //         fontSize: 15,
                                    //         fontWeight: FontWeight.w600,
                                    //         color: MyColor.textBlack,
                                    //       ),
                                    //     ),
                                    //     Container(
                                    //         decoration: BoxDecoration(
                                    //             color: Colors.black87,
                                    //             borderRadius:
                                    //                 BorderRadius.circular(100),
                                    //             border: Border.all(
                                    //               color: MyColor.textLight,
                                    //               width: 1,
                                    //             )),
                                    //         height: 25,
                                    //         width: 45,
                                    //         child: SwitcherButton(
                                    //           offColor: MyColor.white,
                                    //           onColor: MyColor.green,
                                    //           value: true,
                                    //           onChange: (value) {},
                                    //         )),
                                    //   ],
                                    // ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ])),
                              BottomButtons(
                                  lable: 'Save Card',
                                  ontap: () {
                                    statusOfCard = 'save';
                                    (navigatedFrom == 'navBar')
                                        ? null
                                        : NavigatorToReplace(context, NavBar());
                                  }),
                            ],
                          )
                        ],
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: getScreenSize(context).height / 3,
                            ),
                            Text(
                              'No Card added',
                              style: TextStyle(
                                color: MyColor.purple,
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter',
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                NavigatorTo(context, NewCardScreen());
                              },
                              child: Container(
                                height: 50,
                                width: 335 * w,
                                decoration: BoxDecoration(
                                  color: Color(0xffF6F2FF),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: MyColor.purple,
                                    width: 1,
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_box_outlined,
                                      color: MyColor.purple,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Add new card',
                                      style: TextStyle(
                                        color: MyColor.purple,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Inter',
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
              }
            },
          ),
        ),
      ),
    ));
  }
}
