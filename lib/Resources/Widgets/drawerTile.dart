import '../MediaQuery/media_query.dart';
import '../Paths/AssetsPath.dart';
import '../Paths/imports.dart';

class DrawerTile extends StatelessWidget {
  final String lable;
  final String icon;
  final  ontap;
  final  modechanger;
  const DrawerTile( {super.key, required this.lable,  required this.icon, this.modechanger, this.ontap});

  @override
  Widget build(BuildContext context) {
    final fullHeight= getScreenSize(context).height;
    final fullWidth=  getScreenSize(context).width;
    final w  =getScreenSize(context).width*(1/375);
    final h= getScreenSize(context).height*(1/812);
    return  InkWell(
      onTap: (){
        ontap();
      },
      child:  SizedBox(
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(icon),
                SizedBox(width: 5,),
                Text(lable ,style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: MyColor.textBlack,
                    fontFamily: 'Inter'
                ),),
              ],
            ),
            (modechanger != null) ? modechanger: Text(''),

          ],
        ),
      )
    );
  }
}
