import 'package:provider/provider.dart';

import '../../Providers/gender_provider.dart';
import '../../Veiw/auth_screens/CreateAccountScreen.dart';
import '../MediaQuery/media_query.dart';
import '../Navigators/navigators.dart';
import '../Paths/imports.dart';

class Genderselecter extends StatelessWidget {
  final String lable;
  const Genderselecter({super.key, required this.lable});

  @override
  Widget build(BuildContext context) {
    return  Consumer<GenderProvider>(
      builder: (BuildContext context, GenderProvider value, Widget? child) {
        final w =getScreenSize(context).width*(1/375);

        return  InkWell(
          focusColor: Colors.transparent,
          hoverColor:Colors.transparent,
          highlightColor:Colors.transparent,
          splashColor:Colors.transparent,
          onTap: (){
            value.change();
            NavigatorToReplace(context, Createaccountscreen());
            (lable == 'Man') ?  value.change():
             value.change();
          },
          child: Container(
            height: 60,
            width: 152*w,
            decoration: BoxDecoration(
                color:(lable == 'Man') ?  (value.selectedman)?MyColor.grey: MyColor.purple:
                (value.selectedwoman)?MyColor.purple: MyColor.grey,

                borderRadius: BorderRadius.circular(10)
            ),
            child:  Center(
              child: Text( lable,
                textAlign:TextAlign.center,
                style: TextStyle(
                  fontSize: 17 ,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500 ,
                  color:(lable == 'Man') ? value.selectedman? MyColor.textLight: MyColor.white:
                  value.selectedwoman? MyColor.white: MyColor.textLight,
                ),),
            ),
          ),
        );
      },

    );
  }
}
