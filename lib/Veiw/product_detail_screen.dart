import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:laza/Models/Size-seleter_model.dart';
import 'package:laza/Models/product_image_modal.dart';
import 'package:laza/Models/review_model.dart';
import 'package:laza/Providers/product_detail_provider.dart';
import 'package:laza/Providers/size_selector_provider.dart';
import 'package:laza/Resources/MediaQuery/media_query.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/Paths/AssetsPath.dart';
import 'package:laza/Resources/Widgets/review_tile.dart';
import 'package:laza/Veiw/reviews_screen.dart';
import 'package:provider/provider.dart';

import '../Resources/Paths/imports.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductDetailProvider>(context, listen: false);
    final sizeprovider =
        Provider.of<SizeSelectorProvider>(context, listen: false);
    print('build');
    final w = getScreenSize(context).width * (1 / 375);
    final h = getScreenSize(context).height * (1 / 812);

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
                  children: [
            Consumer<ProductDetailProvider>(
                builder: (BuildContext context, value, child) {
              return Container(
                height: getScreenSize(context).height / 2,
                width: getScreenSize(context).width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            ProductImageList[provider.selectedIndex].imagePath),
                        fit: BoxFit.cover)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 20 ,top: 20),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          onTap: (){
                            NavigatorPop(context);
                          },
                          child: Container(
                            height: 45 ,
                            width: 45,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColor.grey
                            ),
                            child: const Icon(Icons.arrow_back_rounded, size: 25,color: MyColor.textBlack,),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(right: 20,top: 20),
                      child: InkWell(
                          onTap: (){
                            NavigatorTo(context, CartScreen());
                          },
                          child: SvgPicture.asset(Images.cart)),
                    ),
                  ],
                ),
              );
            }),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Men's Printed Pullover Hoodie",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Inter',
                          color: MyColor.textLight,
                        ),
                      ),
                      Text(
                        "Price     ",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Inter',
                          color: MyColor.textLight,
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nike Club Fleece",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                          color: MyColor.textBlack,
                        ),
                      ),
                      Text(
                        "\$120",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                          color: MyColor.textBlack,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    height: 77,
                    child: ListView.builder(
                        itemCount: ProductImageList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Consumer<ProductDetailProvider>(
                              builder: (BuildContext context, value, child) {
                                return InkWell(
                                  onTap: () {
                                    provider.imageChange(index);
                                    print(index);
                                  },
                                  child: Container(
                                      width: 77,
                                      height: 77,
                                      decoration: BoxDecoration(
                                     color: MyColor.grey,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                ProductImageList[index].imagePath),
                                            fit: BoxFit.cover),
                                      )),
                                );
                              },
                            ),
                          );
                        }),
                  ),
                  const SizedBox(height: 15,),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Size",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                          color: MyColor.textBlack,
                        ),
                      ),
                      Text(
                        "Size Guide",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Inter',
                          color: MyColor.textLight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15,),

                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                        itemCount: SizeSelectoreList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Consumer<SizeSelectorProvider>(
                              builder: (BuildContext context, value, child) {
                                return InkWell(
                                    onTap: () {
                                      value.selectedSize(index);
                                    },
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: (value.selectedIndex == index)
                                            ? MyColor.textLight
                                            : MyColor.grey,
                                      ),
                                      child: Center(
                                        child: Text(
                                          SizeSelectoreList[index].size,
                                          style: TextStyle(
                                            color: (value.selectedIndex == index)
                                                ? MyColor.white
                                                : MyColor.textBlack,
                                            fontFamily: 'Inter',
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ));
                              },
                            ),
                          );
                        }),
                  ),
                  const SizedBox(height: 15,),

                  Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Inter',
                              color: MyColor.textBlack,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 335 * w,
                        height: 63,
                        child: const Text(
                          "The Nike Throwback Pullover Hoodie is made from premium French terry fabric that blends a performance feel with     ",
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 13,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Inter',
                            color: MyColor.textLight,
                          ),
                        ),
                      ),

                    ],
                  ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Reviews",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                          color: MyColor.textBlack,
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          NavigatorTo(context, const ReviewsScreen());
                        },
                        child: const Text(
                          "View all",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Inter',
                            color: MyColor.textLight,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15,),
                 ReviewTile(ratings: reveiwList[0].ratings, review: reveiwList[0].reveiw, userName: reveiwList[0].name),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Total Price ",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Inter',
                              color: MyColor.textBlack,
                            ),
                          ),
                          Text(
                            "with VAT,SD",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Inter',
                              color: MyColor.textLight,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$205",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                          color: MyColor.textBlack,
                        ),
                      ),

                    ],
                  )
                ],
              ),
            ),
                  ],
                ),
          ),
      bottomNavigationBar:  BottomButtons(lable: 'Add to Cart', ontap: () {}),
      ),

    );
  }
}
