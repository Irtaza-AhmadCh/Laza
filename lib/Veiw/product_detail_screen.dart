import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:laza/Models/Size-seleter_model.dart';
import 'package:laza/Models/product_image_modal.dart';
import 'package:laza/Models/review_model.dart';
import 'package:laza/Providers/bottom_buttom_provider.dart';
import 'package:laza/Providers/cart_add_product.dart';
import 'package:laza/Providers/product_detail_provider.dart';
import 'package:laza/Providers/size_selector_provider.dart';
import 'package:laza/Resources/MediaQuery/media_query.dart';
import 'package:laza/Resources/NavigationBar/nav_bar.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/Paths/AssetsPath.dart';
import 'package:laza/Resources/Widgets/review_tile.dart';
import 'package:laza/Veiw/reviews_screen.dart';
import 'package:provider/provider.dart';

import '../Firebase/DataBase/user_cart.dart';
import '../Resources/Paths/imports.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  List ProductimagePath;
  List Size;
  List ProductReviews;
  String Productname;
  String Productdescription;
  String Producttype;
  String ProductId;
  int Productprice;
   ProductDetailScreen({super.key,
    required this.Productprice,
    required this.Producttype,
    required this.Productname,
    required this.ProductimagePath,
    required this.Size,
    required this.Productdescription,
    required this.ProductReviews,
     required this.ProductId,});

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
                        image: NetworkImage(

                        widget.ProductimagePath[(value.selectedIndex < widget.ProductimagePath.length)? value.selectedIndex :0].toString()                            ),
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
                            navigatedFrom ='';
                            NavigatorTo(context, const CartScreen());
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
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 260*w,
                        child: Text(
                          widget.Productname,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Inter',
                            color: MyColor.textLight,
                          ),
                        ),
                      ),
                      const Text(
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
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.Producttype,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                          color: MyColor.textBlack,
                        ),
                      ),
                      Text(
                        "\$${widget.Productprice.toString()},",
                        style: const TextStyle(
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
                        itemCount:
                            widget.ProductimagePath.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          print( widget.ProductimagePath.length);
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
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                widget.ProductimagePath[index]),
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
                        itemCount:  widget.Size.length,
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
                                          widget.Size[index],
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
                        child:  Text(
                          widget.Productdescription,
                          maxLines: 2,
                          style: const TextStyle(
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
                          NavigatorTo(context,  ReviewsScreen(
                            productId: widget.ProductId,
                          ));
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
                 ReviewTile(
                     ratings: widget.ProductReviews[0]['rating'],
                     date: widget.ProductReviews[0]['time'],
                     review: widget.ProductReviews[0]['review'],
                     userName: widget.ProductReviews[0]['name']),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     const Column(
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
                        "\$${widget.Productprice+ 10}",
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
      bottomNavigationBar:  Consumer<CartAddProductProvider>(
        builder: (context, value, child){
          return  BottomButtons(lable: 'Add to Cart', ontap: () {

            value.addToCart(
                context,
                productId: widget.ProductId, qty: 1,
                price:widget.Productprice, name: widget.Productname,
                type: widget.Producttype, image: widget.ProductimagePath[0]);
            Provider.of<BottomButtomProvider>(context, listen: false).startloading();
// Cart.addCart(productId: widget.ProductId.toString());
          });
        },
      ),
      ),

    );
  }
}
