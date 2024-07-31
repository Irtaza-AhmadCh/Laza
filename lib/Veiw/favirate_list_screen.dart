import 'package:laza/Resources/Widgets/reuseable_appbar.dart';
import 'package:laza/Veiw/cart_screen.dart';

import '../Models/new_arrival_model.dart';
import '../Resources/MediaQuery/media_query.dart';
import '../Resources/NavigationBar/nav_bar.dart';
import '../Resources/Navigators/navigators.dart';
import '../Resources/Paths/AssetsPath.dart';
import '../Resources/Paths/imports.dart';
import '../Resources/Widgets/new_arrival_tile.dart';

class FavirateListScreen extends StatefulWidget {
  const FavirateListScreen({super.key});

  @override
  State<FavirateListScreen> createState() => _FavirateListScreenState();
}

class _FavirateListScreenState extends State<FavirateListScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
         title:  Text(
            'Wishlist',
            style: TextStyle(
              fontFamily: "Inter",
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: MyColor.textBlack,
            ),
          ),
          centerTitle: true,
          backgroundColor: MyColor.white,
          toolbarHeight: 90,
          leading: (  navigatedFrom == 'navBar') ?Text('') :Padding(
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
                  onTap:(){
                    navigatedFrom = '';
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
                const Text('50 items',
                  textAlign:  TextAlign.center,
                  style:  TextStyle(
                    fontWeight:FontWeight.w600 ,
                    fontSize:17 ,
                    fontFamily: 'Inter',
                    color: MyColor.textBlack,
                  ),),
                const Text('In wishlist',
                  textAlign:  TextAlign.center,
                  style:  TextStyle(
                    fontWeight:FontWeight.w400 ,
                    fontSize:15,
                    fontFamily: 'Inter',
                    color: MyColor.textLight,
                  ),),
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
