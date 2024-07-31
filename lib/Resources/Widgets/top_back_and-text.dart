import 'package:laza/Resources/Navigators/navigators.dart';

import '../MediaQuery/media_query.dart';
import '../Paths/AssetsPath.dart';
import '../Paths/imports.dart';

class TopHeader extends StatelessWidget {
  final String lable;
  const TopHeader({super.key, required this.lable,});

  @override
  Widget build(BuildContext context) {
    final fullHeight= getScreenSize(context).height;
    final fullWidth=  getScreenSize(context).width;
    final w  =getScreenSize(context).width*(1/375);
    final h= getScreenSize(context).height*(1/812);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
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
                child: const Icon(Icons.arrow_back_rounded, size: 30,),
              ),
            ),
          ],
        ),
        SizedBox(height: 15 *h ,),
         Text(lable,
          textAlign:  TextAlign.center,
          style: const TextStyle(
            fontWeight:FontWeight.w600 ,
            fontSize:28 ,
            fontFamily: 'Inter',
            color: MyColor.textBlack,
          ),),
      ],
    );
  }
}
