import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laza/Firebase/DataBase/User_data/get_user_data.dart';
import 'package:laza/Models/wishlist_model.dart';
import 'package:laza/Providers/wishList_provider.dart';
import 'package:laza/Resources/Widgets/reuseable_appbar.dart';
import 'package:laza/Veiw/cart_screen.dart';
import 'package:laza/Veiw/product_detail_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../Models/new_arrival_model.dart';
import '../Resources/MediaQuery/media_query.dart';
import '../Resources/NavigationBar/nav_bar.dart';
import '../Resources/Navigators/navigators.dart';
import '../Resources/Paths/AssetsPath.dart';
import '../Resources/Paths/imports.dart';
import '../Resources/Widgets/new_arrival_tile.dart';

class FavirateListScreen extends StatefulWidget {
  const FavirateListScreen({super.key});

  @override
  State<FavirateListScreen> createState() => _FavirateListScreenState();
}

class _FavirateListScreenState extends State<FavirateListScreen> {
  final snapshotRef = FirebaseFirestore.instance
      .collection('Wishlist')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('WishlistItem')
      .snapshots();
  bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    final w = getScreenSize(context).width * (1 / 375);

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Wishlist',
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: MyColor.textBlack,
                ),
              ),
              centerTitle: true,
              backgroundColor: MyColor.white,
              toolbarHeight: 90,
              leading: (navigatedFrom == 'navBar')
                  ? Text('')
                  : Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          NavigatorPop(context);
                        },
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: MyColor.grey),
                          child: const Icon(
                            Icons.arrow_back_rounded,
                            size: 25,
                            color: MyColor.textBlack,
                          ),
                        ),
                      )),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: InkWell(
                      onTap: () {
                        navigatedFrom = '';
                        NavigatorTo(context, CartScreen());
                      },
                      child: SvgPicture.asset(Images.cart)),
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
            body: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Consumer<WishlistProvider>(
                    builder: (context, value, child) {
                  return SingleChildScrollView(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: snapshotRef,
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text(
                                  'Some Error occur',
                                  style: TextStyle(
                                    color: MyColor.red,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              );
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child: LoadingAnimationWidget.stretchedDots(
                                      color: MyColor.purple, size: 50));
                            } else {
                              return(snapshot.data!.docs.length > 0 )? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          '${snapshot.data!.docs.length} items',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17,
                                            fontFamily: 'Inter',
                                            color: MyColor.textBlack,
                                          ),
                                        ),
                                        const Text(
                                          'In wishlist',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                            fontFamily: 'Inter',
                                            color: MyColor.textLight,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Consumer<WishlistProvider>(
                                      builder: (context, value, child) {


                                        return SizedBox(
                                            height:
                                                getScreenSize(context).height,
                                            width: getScreenSize(context).width,
                                            child:  GridView.builder(
                                                itemCount:
                                                    snapshot.data!.docs.length,
                                                shrinkWrap: true,
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        mainAxisSpacing: 6,
                                                        crossAxisSpacing: 3,
                                                        mainAxisExtent: 290,
                                                        childAspectRatio: 1),
                                                itemBuilder: (context, index) {
                                                  List fliPro = snapshot
                                                      .data!.docs
                                                      .where((r) {
                                                    return false;
                                                  }).toList();

                                                  // print('Product ${fliPro}');
                                                  return InkWell(
                                                    onTap: () {
                                                      NavigatorTo(
                                                          context,
                                                          ProductDetailScreen(
                                                              Productprice: snapshot
                                                                      .data!
                                                                      .docs[index]
                                                                  [
                                                                  'Productprice'],
                                                              Producttype: snapshot
                                                                      .data!
                                                                      .docs[index]
                                                                  [
                                                                  'Producttype'],
                                                              Productname: snapshot
                                                                      .data!
                                                                      .docs[index]
                                                                  [
                                                                  'Productname'],
                                                              ProductimagePath: snapshot
                                                                      .data!
                                                                      .docs[index]
                                                                  ['ProductimagePath'],
                                                              Size: snapshot.data!.docs[index]['Size'],
                                                              Productdescription: snapshot.data!.docs[index]['Productdescription'],
                                                              ProductReviews: snapshot.data!.docs[index]['ProductReviews'],
                                                              ProductId: snapshot.data!.docs[index]['ProductId']));
                                                    },
                                                    child: Consumer<
                                                        WishlistProvider>(
                                                      builder:
                                                          (BuildContext context,
                                                              WishlistProvider
                                                                  value,
                                                              Widget? child) {
                                                        return NewArrivalTile(
                                                          favProductId: snapshot
                                                              .data!
                                                              .docs[index]
                                                          ['ProductId'],
                                                          image: snapshot.data!
                                                                  .docs[index][
                                                              'ProductimagePath'],
                                                          description: snapshot
                                                                  .data!
                                                                  .docs[index][
                                                              'Productdescription'],
                                                          type: snapshot.data!
                                                                  .docs[index]
                                                              ['Producttype'],
                                                          price: snapshot.data!
                                                                  .docs[index]
                                                              ['Productprice'],
                                                          productId: snapshot
                                                              .data!
                                                              .docs[index]
                                                                  ['ProductId']
                                                              .toString(),
                                                          position: index,
                                                          name: snapshot.data!
                                                                  .docs[index]
                                                              ['Productname'],
                                                          Size: snapshot.data!
                                                                  .docs[index]
                                                              ['Size'],
                                                          reviews: snapshot
                                                                  .data!
                                                                  .docs[index][
                                                              'ProductReviews'],
                                                          brand: snapshot.data!
                                                                  .docs[index]
                                                              ['Productbrand'],
                                                        );
                                                      },
                                                    ),
                                                  );
                                                })
                                        );
                                      },
                                    )
                                  ]): Center(child: Container(
                            height: 300*w,width: 300*w,
                            child: Lottie.asset(
                            Animations.emptybox, repeat: true,fit: BoxFit.cover)));
                            }
                          })
                  );
                }))));
  }
}
