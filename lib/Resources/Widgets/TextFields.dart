import 'package:laza/Providers/textfeild_tick_provider.dart';
import 'package:provider/provider.dart';

import '../MediaQuery/media_query.dart';
import '../Paths/AssetsPath.dart';
import '../Paths/imports.dart';

class MyTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String hintText;
  final String? fieldType;
  final   onchange;
  final  validator;
  final SuffixIcon;
  const MyTextField({super.key, required this.title,
    required this.controller, required this.hintText,
       this.onchange,  this.validator,
    this.SuffixIcon, this.fieldType,  });

  @override
  Widget build(BuildContext context) {
    return    Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(title,style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              fontFamily: 'Inter',
              color: MyColor.textLight
          ),),
          Consumer<TextfeildTickProvider>(
            builder: (BuildContext context, TextfeildTickProvider value, Widget? child) {
           return   TextFormField(
                  onChanged:(val){(fieldType?.toLowerCase()== 'password') ?value.passwordchecker(controller.text.toString())
                      : (fieldType?.toLowerCase()== 'email') ? value.emailChecker(controller.text.toString()):
                  (fieldType?.toLowerCase()== 'name')?value.namechecker(controller.text.toString()) : null; },

                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                      color: MyColor.textBlack
                  ),
                  controller: controller,
                  cursorErrorColor: MyColor.red,
                  validator: validator,
                  decoration:  InputDecoration(

                    hintText: hintText,

                    hintStyle:  const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                        color: MyColor.textBlack
                    ),
                    suffixIcon: SuffixIcon,
                    enabledBorder: const UnderlineInputBorder(
                        borderSide:BorderSide(color: Color(0xffE7E8EA))
                    ),
                    disabledBorder:  const UnderlineInputBorder(
                        borderSide:BorderSide(color: Color(0xffE7E8EA))
                    ),
                    focusedBorder:  const UnderlineInputBorder(
                      borderSide:BorderSide(color: MyColor.textLight),
                    ),
                    errorBorder:  const UnderlineInputBorder(
                        borderSide:BorderSide(color: MyColor.red)
                    ),
                    focusedErrorBorder:  const UnderlineInputBorder(
                        borderSide:BorderSide(color: MyColor.red)
                    ),

                  )
              );
            },

          )
        ]);
  }
}
