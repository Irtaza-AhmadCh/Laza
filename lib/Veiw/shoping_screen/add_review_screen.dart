import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:laza/Firebase/DataBase/review_adding/review.dart';
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
 String? ProjectId;
   AddReviewScreen({super.key, this.ProjectId});

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
                      const SizedBox(height: 20,),
                      const Row(
                        children: [
                          Text('How was your experience ?' ,style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: MyColor.textBlack,
                          ),)
                        ],
                      ),
                      const SizedBox(height: 10,),
                      SizedBox(
                        height: 213,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: TextFormField(
                            maxLines: 10,
                            controller: reveiwController,
                            decoration: const InputDecoration(
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
                      const SizedBox(height: 10,),
                      const Row(
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
                          const Text( '0.0', style: TextStyle(
                            color:MyColor.textBlack ,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                          ),),
                          SizedBox(
                            width: getScreenSize(context).width -77,
                            child: Consumer<StarSliderProvider>(
                              builder: (context, value , child){
                                return  Slider(value: value.value,
                                    activeColor:  MyColor.purple,
                                    inactiveColor: MyColor.grey,
                                    max: 5,
                                    label: value.value.toString(),
                                    min: 0,
                                    divisions: 10,
                                    onChanged: (val){
                                     value.changeValue(val);
                                    });
                              },

                            ),
                          ),
                          const Text( '5.0', style: TextStyle(
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

            addReview(widget.ProjectId,
                nameController.text.toString(),
                reveiwController.text.toString() ,
                provider.value, context
            );
            setState(() {

            });
          }),
    ));
  }
}
