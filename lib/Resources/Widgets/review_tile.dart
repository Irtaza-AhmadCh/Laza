import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../MediaQuery/media_query.dart';
import '../Paths/AssetsPath.dart';
import '../Paths/imports.dart';

class ReviewTile extends StatelessWidget {
 String review;
 double ratings;
 String userName;

   ReviewTile({super.key, required this.ratings, required this.review,required this.userName,
   });

  @override
  Widget build(BuildContext context) {
    final fullHeight= getScreenSize(context).height;
    final fullWidth=  getScreenSize(context).width;
    final w  =getScreenSize(context).width*(1/375);
    final h= getScreenSize(context).height*(1/812);
    return  SizedBox(
      height: 118,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 40 ,
                    width: 40,
                    decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage(PngImages.shirt,),
                            fit: BoxFit.fill
                        ),
                        shape: BoxShape.circle
                    ),
                  ),
                  const SizedBox(width: 10,),
                   Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter',
                            color: MyColor.textBlack,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.access_time, color: MyColor.textLight,size: 11,),
                            SizedBox(width: 2,),
                            Text(
                              '13 Sep, 2020',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Inter',
                                color: MyColor.textLight,
                              ),
                            ),
                          ],
                        ),
                      ]

                  ),
                ],
              ),
              Column(
                children: [
                   Row(
                    children: [
                      Text(
                        ratings.toString(),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                          color: MyColor.textBlack,
                        ),
                      ),
                      SizedBox(width: 5,),
                      Text(
                        "Rating ",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Inter',
                          color: MyColor.textLight,
                        ),
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 13,
                    width: 57,
                    child: RatingBar.builder(
                      initialRating: ratings,
                      itemSize: 10,
                      minRating: 1,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      ignoreGestures: true,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        size: 5,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 15,),
          SizedBox(
            width: 335 * w,
            height: 63,
            child:  Text(
              review,
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
    );
  }
}
