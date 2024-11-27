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
import '../Models/choose_brand_model.dart';
import '../Resources/Widgets/choose_brand.dart';

class AllBrandScreen extends StatefulWidget {
  const AllBrandScreen({super.key});

  @override
  State<AllBrandScreen> createState() => _AllBrandScreenState();
}

class _AllBrandScreenState extends State<AllBrandScreen> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      appBar: appBar(context, title: 'All Brands'),
      body:   Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
            height: getScreenSize(context).height,
            width: getScreenSize(context).width,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Brands').snapshots(),
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
                          mainAxisExtent: 60,
                          childAspectRatio: 1

                      ),
                      itemBuilder: (context,index){
                        return  ChooseBrandTile(brandName: snapshot.data!.docs[index]['BrandName'], brandLogo: snapshot.data!.docs[index]['BrandLogo']);

                      });
                }

              },
            )
        ),
      ),
    ));
  }
}
