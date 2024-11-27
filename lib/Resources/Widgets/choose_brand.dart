import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Veiw/shoping_screen/choosebrandScreen.dart';

import '../MediaQuery/media_query.dart';
import '../Paths/AssetsPath.dart';
import '../Paths/imports.dart';

class ChooseBrandTile extends StatelessWidget {
  final String brandName;
  final String brandLogo;
  const ChooseBrandTile({super.key, required this.brandName, required this.brandLogo});

  @override
  Widget build(BuildContext context) {
    final fullHeight= getScreenSize(context).height;
    final fullWidth=  getScreenSize(context).width;
    final w  =getScreenSize(context).width*(1/375);
    final h= getScreenSize(context).height*(1/812);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        focusColor: Colors.transparent,
        hoverColor:Colors.transparent,
        highlightColor:Colors.transparent,
        splashColor:Colors.transparent,
        onTap: (){
          NavigatorTo(context, ChooseBrandScreen(brandLogo: brandLogo, brandname: brandName));
        },
        child: Container(
          height: 50,
          width: 115,
          decoration: BoxDecoration(
              color: MyColor.grey,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 5),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 7),
                    decoration: BoxDecoration(
                      color: MyColor.white,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(image: NetworkImage(brandLogo))
                    ),

                  ),
                  const SizedBox(width: 5,),
                   Text(brandName, style: TextStyle(
                      color:MyColor.textBlack ,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      fontFamily: 'Inter'
                  ),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
