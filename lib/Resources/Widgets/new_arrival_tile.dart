import '../MediaQuery/media_query.dart';
import '../Paths/AssetsPath.dart';
import '../Paths/imports.dart';

class NewArrivalTile extends StatelessWidget {
  final String image;
  final String name;
  final String type;
  final String price;
  const NewArrivalTile({super.key, required this.image, required this.name, required this.type, required this.price, });

  @override
  Widget build(BuildContext context) {
    final fullHeight= getScreenSize(context).height;
    final fullWidth=  getScreenSize(context).width;
    final w  =getScreenSize(context).width*(1/375);
    final h= getScreenSize(context).height*(1/812);
    return  SizedBox(
      height: 257,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 203 ,
              width: 160,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(image),fit:  BoxFit.contain)
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(Images.heart),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5,),
            Text(name,style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
              color: MyColor.textBlack,
            ),),
            Text(type,style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
              color: MyColor.textBlack,
            ),),
            SizedBox(height: 5,),

            Text('\$$price',style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              fontFamily: 'Inter',
              color: MyColor.textBlack,
            ),),

          ],

      ),
    );
  }
}
