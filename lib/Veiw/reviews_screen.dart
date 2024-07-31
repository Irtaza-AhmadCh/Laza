import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:laza/Resources/MediaQuery/media_query.dart';
import 'package:laza/Resources/Paths/AssetsPath.dart';
import 'package:laza/Resources/Widgets/review_tile.dart';
import 'package:laza/Veiw/shoping_screen/add_review_screen.dart';

import '../Models/review_model.dart';
import '../Resources/Navigators/navigators.dart';
import '../Resources/Paths/imports.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(
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
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '300 Reviews',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                      color: MyColor.textBlack,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                    '4.4',
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
                        itemBuilder: (context, _) => Icon(
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
                  NavigatorToReplace(context, AddReviewScreen());
                },
                child: Container(
                  height: 35 ,
                  width: 114,
                  decoration: BoxDecoration(
                    color:Color(0xffFF7043),
                    borderRadius: BorderRadius.circular(5) ,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Images.addReview),
                      SizedBox(width: 5,),
                      Text('Add Reveiw',
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
          SizedBox(height: 30,),
          Container(
            height: getScreenSize(context).height - 165,
            child: ListView.builder(
              shrinkWrap: false,
              itemCount: reveiwList.length,
                itemBuilder: (context,index){
              return ReviewTile(
                  ratings: reveiwList[index].ratings,
                  review: reveiwList[index].reveiw,
                  userName: reveiwList[index].name);
            }),
          )
      ]
      ),

    )
    );
  }
}
