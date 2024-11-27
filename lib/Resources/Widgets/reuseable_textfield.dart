import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../Colors/Colors.dart';
import '../Paths/imports.dart';

class ReuseableTextfield extends StatelessWidget {
  String title;
  String hint;
  TextEditingController controller;
   ReuseableTextfield({super.key,  required this.title, required this.controller, required this.hint,});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          children: [
            Text(title ,style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 17,
              color: MyColor.textBlack,
            ),)
          ],
        ),
        SizedBox(height: 10,),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: TextFormField(
            controller:controller,
           // inputFormatters: [
           //   TextInputFormatter.withFunction(formatFunction)
           // ],
           decoration:  InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: MyColor.textLight,
                fontSize: 15,
                fontWeight:FontWeight.w400 ,
                fontFamily: 'Inter',
              ),
              filled: true,
              fillColor: MyColor.grey,

            ),
          ),
        ),
      ],
    );
  }
}
