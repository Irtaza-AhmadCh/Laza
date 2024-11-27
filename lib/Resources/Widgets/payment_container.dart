import 'package:flutter/cupertino.dart';

import '../Colors/Colors.dart';
import '../Paths/imports.dart';

class ReuseablePaymentcard extends StatelessWidget {
  String title;
  String data;
  ReuseablePaymentcard({super.key,  required this.title, required this.data,});

  @override
  Widget build(BuildContext context) {
    return   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title ,style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          fontSize: 17,
          color: MyColor.textBlack,
        ),),
        SizedBox(height: 10,),
        Container(
          height: 50,
          decoration:BoxDecoration(
              color: MyColor.grey,
              borderRadius: BorderRadius.circular(10)
          ),
          child:  Row(
            children: [
              SizedBox(width: 15,),
              Text(data ,style: TextStyle(
                color: MyColor.textLight,
                fontSize: 15,
                fontWeight:FontWeight.w400 ,
                fontFamily: 'Inter',
              ),)
            ],
          ),
        )
      ],
    );
  }
}
