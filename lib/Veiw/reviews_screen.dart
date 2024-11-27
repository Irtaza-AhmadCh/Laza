import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:laza/Providers/reviw_provider.dart';
import 'package:laza/Resources/MediaQuery/media_query.dart';
import 'package:laza/Resources/Paths/AssetsPath.dart';
import 'package:laza/Resources/Widgets/review_tile.dart';
import 'package:laza/Veiw/shoping_screen/add_review_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../Models/review_model.dart';
import '../Resources/Navigators/navigators.dart';
import '../Resources/Paths/imports.dart';

class ReviewsScreen extends StatefulWidget {
  String? productId;
   ReviewsScreen({super.key,  this.productId});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final snapshotRef = FirebaseFirestore.instance.collection('Products').snapshots();

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    final productRef = FirebaseFirestore.instance.collection('Products').doc(widget.productId);
    final docSnapshot = await productRef.get();
    return docSnapshot;
  }


  @override
  Widget build(BuildContext context) {
    //
    // final reviewProvider = Provider.of<ReviewProvider>(context);
    // reviewProvider.getReviews(widget.productId);
    return  Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reviews',
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
        leading: Padding(
            padding: const EdgeInsets.only(left: 20),
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
      ),
    body: Consumer(
      builder: (context, value, child){
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RefreshIndicator(
              onRefresh: (){
                getUserData();
                setState(() {

                });
                return Future.delayed(const Duration(seconds: 3));
              },
              child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              ' Reviews',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter',
                                color: MyColor.textBlack,
                              ),
                            ),
                            Row(
                              children: [
                                const Text(
                                  '3.5',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Inter',
                                    color: MyColor.textBlack,
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(left: 2 ,top: 2),
                                  child: SizedBox(
                                    height: 13,
                                    width: 57,
                                    child: RatingBar.builder(
                                      initialRating: 4,
                                      itemSize: 11,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      itemCount: 5,
                                      ignoreGestures: true,
                                      itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          size: 5,
                                          color: MyColor.mustard
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        InkWell(
                          onTap: (){
                            NavigatorTo(context, AddReviewScreen(ProjectId: widget.productId,));
                          },
                          child: Container(
                            height: 35 ,
                            width: 114,
                            decoration: BoxDecoration(
                              color:const Color(0xffFF7043),
                              borderRadius: BorderRadius.circular(5) ,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(Images.addReview),
                                const SizedBox(width: 5,),
                                const Text('Add Reveiw',
                                  style: TextStyle(
                                      color: MyColor.white,
                                      fontSize:  13,
                                      fontWeight: FontWeight.w500 ,
                                      fontFamily: 'Inter'
                                  ),)

                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 30,),
                    Container(
                      height: getScreenSize(context).height -162,
                      child:   FutureBuilder<DocumentSnapshot<Map<String, dynamic>>> (
                        future: getUserData(),
                        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {

                          if(snapshot.hasError){
                            return   const Center(
                              child:    Text('No Data found', style: TextStyle(
                                color: MyColor.textBlack,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600 ,
                                fontSize: 17,
                              ),),
                            );
                          }else if(snapshot.connectionState == ConnectionState.waiting){
                            return Center(
                                child:   LoadingAnimationWidget.stretchedDots(color: MyColor.purple, size: 50)
                            );

                          }else{


                            return  ListView.builder(
                                shrinkWrap: false,
                                itemCount:snapshot.data!.data()!['reviews'].length,
                                itemBuilder: (context, index) {
                                  return  ReviewTile(
                                      ratings: snapshot.data!.data()!['reviews'][index]['rating'] ,
                                      date: snapshot.data!.data()!['reviews'][index]['time'],
                                      review: snapshot.data!.data()!['reviews'][index]['review'],
                                      userName:snapshot.data!.data()!['reviews'][index]['name']);
                                });
                          }

                        },
                      ),


                    )
                  ]
              ),
            ),

          ),
        );
      },
    
     
    )
    );
  }

}
