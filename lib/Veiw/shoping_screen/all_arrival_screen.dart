import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/Widgets/reuseable_appbar.dart';
import 'package:laza/Veiw/product_detail_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../Models/new_arrival_model.dart';
import '../../Providers/wishList_provider.dart';
import '../../Resources/Colors/Colors.dart';
import '../../Resources/MediaQuery/media_query.dart';
import '../../Resources/Widgets/new_arrival_tile.dart';

class AllArrivalScreen extends StatefulWidget {
  const AllArrivalScreen({super.key});

  @override
  State<AllArrivalScreen> createState() => _AllArrivalScreenState();
}

class _AllArrivalScreenState extends State<AllArrivalScreen> {
  final snapshotRef = FirebaseFirestore.instance.collection('Products').snapshots();

  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      appBar: appBar(context, title: 'Arrivals'),
      body:   Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
            height: getScreenSize(context).height,
            width: getScreenSize(context).width,
            child:  StreamBuilder<QuerySnapshot>(
              stream: snapshotRef,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if(snapshot.hasError){
                  return const Center(
                    child: Text('Some Error occur', style: TextStyle(
                      color: MyColor.red,
                      fontSize: 28,
                      fontWeight:FontWeight.w600 ,
                      fontFamily: 'Inter',
                    ),),
                  );
                }else if( snapshot.connectionState ==ConnectionState.waiting){
                  return  Center(
                      child: LoadingAnimationWidget.stretchedDots(color: MyColor.purple,
                          size: 50)

                  );
                }else{
                  return  GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap:true,
                      gridDelegate: const  SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 6,
                          crossAxisSpacing: 3,
                          mainAxisExtent: 290,
                          childAspectRatio: 1

                      ),
                      itemBuilder: (context,index){
                        print('image ${snapshot.data!.docs[index]['images']}');
                        return InkWell(
                          onTap: (){
                            NavigatorTo(context,  ProductDetailScreen(

                                Productprice: snapshot.data!.docs[index]['price'],
                                Producttype: snapshot.data!.docs[index]['type'],
                                Productname: snapshot.data!.docs[index]['name'],
                                ProductimagePath:snapshot.data!.docs[index]['images'],
                                Size: snapshot.data!.docs[index]['sizes'],
                                Productdescription: snapshot.data!.docs[index]['description'],
                                ProductReviews: snapshot.data!.docs[index]['reviews'],
                                ProductId: snapshot.data!.docs[index]['ProductId']

                            ));


                          },
                          child: Consumer<WishlistProvider>(

                            builder: (BuildContext context, WishlistProvider value, Widget? child) {
                              return NewArrivalTile(
                                image: snapshot.data!.docs[index]['images'],
                                description: snapshot.data!.docs[index]['description'],
                                type:snapshot.data!.docs[index]['type'],
                                price: snapshot.data!.docs[index]['price'],
                                productId:snapshot.data!.docs[index]['ProductId'].toString(),
                                position: index,
                                name: snapshot.data!.docs[index]['name'],
                                Size:  snapshot.data!.docs[index]['sizes'],
                                reviews:  snapshot.data!.docs[index]['reviews'],
                                brand:  snapshot.data!.docs[index]['brand'],);
                            },
                          ),

                        );
                      });
                }

              },
            )
        ),
      ),
    ));
  }
}