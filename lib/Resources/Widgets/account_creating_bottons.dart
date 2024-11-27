import '../MediaQuery/media_query.dart';
import '../Paths/AssetsPath.dart';
import '../Paths/imports.dart';

class AccountCreatingBottons extends StatelessWidget {
  final String lable;
  final Color color;
  final String icon;
  final VoidCallback ontap;
  const AccountCreatingBottons({super.key, required this.lable, required this.color, required this.icon,  required this.ontap});

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
        onTap: ontap,
        child: Container(
          height: 50,
          width: 335*w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color ,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(icon),
              Text(lable, style:  TextStyle(
                fontWeight:FontWeight.w600 ,
                fontSize:17 ,
                fontFamily: 'Inter',
                color: MyColor.white,
              ),)
            ],
          ),
        ));
  }
}
