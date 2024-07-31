import 'package:flutter/cupertino.dart';
import 'package:laza/Providers/star_slider_provider.dart';
import 'package:laza/Resources/Widgets/reuseable_textfield.dart';
import 'package:laza/Veiw/reviews_screen.dart';
import 'package:provider/provider.dart';

import '../../Models/review_model.dart';
import '../../Resources/MediaQuery/media_query.dart';
import '../../Resources/Navigators/navigators.dart';
import '../../Resources/Paths/imports.dart';
import '../../Resources/Widgets/reuseable_appbar.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({super.key});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
TextEditingController nameController = TextEditingController();
TextEditingController reveiwController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final w = getScreenSize(context).width * (1 / 375);
    final h = getScreenSize(context).height * (1 / 812);
    final provider = Provider.of<StarSliderProvider>(context, listen: false);
    print(build);
    return SafeArea(
        child:  Scaffold(
appBar:appBar(context, title: 'Reviews'),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                  child: Column(
                    children: [

                      ReuseableTextfield(title: 'Name', controller: nameController, hint: 'Type your name'),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Text('How was your experience ?' ,style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: MyColor.textBlack,
                          ),)
                        ],
                      ),
                      SizedBox(height: 10,),
                      SizedBox(
                        height: 213,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: TextFormField(
                            maxLines: 10,
                            controller: reveiwController,
                            decoration: InputDecoration(
                                hintText: 'Describe your experience?',
                                hintStyle: TextStyle(
                                  color: MyColor.textLight,
                                  fontSize: 15,
                                  fontWeight:FontWeight.w400 ,
                                  fontFamily: 'Inter',
                                ),
                                filled: true,
                                fillColor: MyColor.grey,
                                border:InputBorder.none
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Stars' ,style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: MyColor.textBlack,
                          ),),
                        ],
                      ),

                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text( '0.0', style: TextStyle(
                            color:MyColor.textBlack ,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                          ),),
                          SizedBox(
                            width: 299*w,
                            child: Consumer<StarSliderProvider>(
                              builder: (context, value , child){
                                return  Slider(value: value.value,
                                    activeColor:  MyColor.purple,
                                    inactiveColor: MyColor.grey,
                                    max: 5,
                                    label: value.value.toInt().toString(),
                                    min: 0,
                                    divisions: 5,
                                    onChanged: (val){
                                     value.changeValue(val);
                                    });
                              },

                            ),
                          ),
                          Text( '5.0', style: TextStyle(
                            color:MyColor.textBlack ,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                          ),),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 180*h,),

              ],
            ),
          ),
          bottomNavigationBar: BottomButtons(lable: 'Submit Review', ontap: (){
            reveiwList.add(  ReviewModel(ratings: provider.value,
                name: nameController.text.toString(),
                reveiw:reveiwController.text.toString() ));

            print(reveiwList.length);
            NavigatorToReplace(context, ReviewsScreen());
          }),
    ));
  }
}
