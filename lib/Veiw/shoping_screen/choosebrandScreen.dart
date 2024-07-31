import 'package:laza/Resources/Colors/Colors.dart';
import 'package:laza/Veiw/cart_screen.dart';

import '../../Models/new_arrival_model.dart';
import '../../Resources/MediaQuery/media_query.dart';
import '../../Resources/Navigators/navigators.dart';
import '../../Resources/Paths/AssetsPath.dart';
import '../../Resources/Paths/imports.dart';
import '../../Resources/Widgets/new_arrival_tile.dart';

class ChooseBrandScreen extends StatefulWidget {
 final String brandLogo;
  const ChooseBrandScreen({super.key, required this.brandLogo});

  @override
  State<ChooseBrandScreen> createState() => _ChooseBrandScreenState();
}

class _ChooseBrandScreenState extends State<ChooseBrandScreen> {

  @override
  Widget build(BuildContext context) {
    final w = getScreenSize(context).width*(1/375);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:  Container(
            height: 45,
            width: 68*w,
            decoration: BoxDecoration(
                color: MyColor.grey,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 5),

                child:SvgPicture.asset(widget.brandLogo,fit: BoxFit.fill,height: 25,width: 48,),
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: MyColor.white,
          toolbarHeight: 90,
          leading: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: InkWell(
                splashColor: Colors.transparent,
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
                  child: const Icon(Icons.arrow_back_rounded, size: 25,color: MyColor.textBlack,),
                ),
              )),
          actions: [

              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: InkWell(
                  onTap: (){
                    NavigatorTo(context, CartScreen());
                  },
                    child: SvgPicture.asset(Images.cart)),
            ),
            const SizedBox(width: 20,)        ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Text('50 items',
                          textAlign:  TextAlign.center,
                          style:  TextStyle(
                            fontWeight:FontWeight.w600 ,
                            fontSize:17 ,
                            fontFamily: 'Inter',
                            color: MyColor.textBlack,
                          ),),
                        const Text('Available in stock',
                          textAlign:  TextAlign.center,
                          style:  TextStyle(
                            fontWeight:FontWeight.w400 ,
                            fontSize:15,
                            fontFamily: 'Inter',
                            color: MyColor.textLight,
                          ),),
                      ],
                    ),
                    InkWell(
                      focusColor: Colors.transparent,
                      hoverColor:Colors.transparent,
                      highlightColor:Colors.transparent,
                      splashColor:Colors.transparent,
                      onTap: (){
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(Images.sort),
                                const SizedBox(width: 5,),
                                Text('Sort', style: TextStyle(
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
                  ],
                ),
                SizedBox(height: 30,),
                SizedBox(
                    height: getScreenSize(context).height,
                    width: getScreenSize(context).width,
                    child: GridView.builder(itemCount: NewArrivalList.length,
                        gridDelegate: const  SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 6,
                            crossAxisSpacing: 3,
                            mainAxisExtent: 270,
                            childAspectRatio: 1

                        ),
                        itemBuilder: (context,index){
                          return NewArrivalTile(image: NewArrivalList[index].ProductimagePath,
                              name: NewArrivalList[index].Productname,
                              type: NewArrivalList[index].Producttype,
                              price: NewArrivalList[index].Productprice);
                        })
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
