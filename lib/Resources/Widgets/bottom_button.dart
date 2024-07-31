import '../MediaQuery/media_query.dart';
import '../Paths/AssetsPath.dart';
import '../Paths/imports.dart';

class BottomButtons extends StatelessWidget {
  final String lable;
  final VoidCallback ontap;
  const BottomButtons({super.key, required this.lable,  required this.ontap});

  @override
  Widget build(BuildContext context) {
    final fullHeight= getScreenSize(context).height;
    final fullWidth=  getScreenSize(context).width;
    final w  =getScreenSize(context).width*(1/375);
    final h= getScreenSize(context).height*(1/812);
    return  InkWell(
      focusColor: Colors.transparent,
      hoverColor:Colors.transparent,
      highlightColor:Colors.transparent,
      splashColor:Colors.transparent,
      onTap: (){
        ontap();
      },
      child: Container(
        height: 75,
        width: double.maxFinite,
        color: MyColor.purple,
        child: Padding(
          padding:  const EdgeInsets.only(top: 15),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(lable, style: const TextStyle(
                fontWeight:FontWeight.w500 ,
                fontSize:17 ,
                fontFamily: 'Inter',
                color: MyColor.white,
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
