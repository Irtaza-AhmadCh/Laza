import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laza/Resources/Colors/Colors.dart';
import 'package:laza/Veiw/cart_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../Models/new_arrival_model.dart';
import '../../Providers/wishList_provider.dart';
import '../../Resources/MediaQuery/media_query.dart';
import '../../Resources/Navigators/navigators.dart';
import '../../Resources/Paths/AssetsPath.dart';
import '../../Resources/Paths/imports.dart';
import '../../Resources/Widgets/new_arrival_tile.dart';
import '../product_detail_screen.dart';

class ChooseBrandScreen extends StatefulWidget {
 final String brandLogo;
 final String brandname;

  const ChooseBrandScreen({super.key, required this.brandLogo, required this.brandname});

  @override
  State<ChooseBrandScreen> createState() => _ChooseBrandScreenState();
}

class _ChooseBrandScreenState extends State<ChooseBrandScreen> {

  Future<QuerySnapshot<Map<String, dynamic>>>  getBrandList()async {

    var brand = await FirebaseFirestore.instance.collection('Products').
    where('brand'.toString().toLowerCase(), isEqualTo: widget.brandname.toString().toLowerCase()).get();
return brand;
  }
  @override
  Widget build(BuildContext context) {
    getBrandList();
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

                child:Image(image: NetworkImage(widget.brandLogo))
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
                    NavigatorTo(context, const CartScreen());
                  },
                    child: SvgPicture.asset(Images.cart)),
            ),
            const SizedBox(width: 20,)        ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,),
          child:FutureBuilder<QuerySnapshot<Map<String, dynamic>>> (
    future: getBrandList(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if(snapshot.hasError){
    return const Center(
    child: Text('Some Error occur', style: TextStyle(
    color: MyColor.red,
    fontSize: 28,
    fontWeight:FontWeight.w600 ,
    fontFamily: 'Inter',
    ),),
    );
    }else if( snapshot.connectionState ==ConnectionState.waiting){
    return  Center(
    child: LoadingAnimationWidget.stretchedDots(color: MyColor.purple,
    size: 50)

    );
    }else{



      return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(' ${snapshot.data!.docs.length.toString()} items',
                          textAlign:  TextAlign.center,
                          style:  TextStyle(
                            fontWeight:FontWeight.w600 ,
                            fontSize:17 ,
                            fontFamily: 'Inter',
                            color: MyColor.textBlack,
                          ),),
                        Text('Available in stock',
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
                                const Text('Sort', style: TextStyle(
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
                const SizedBox(height: 30,),
                SizedBox(
                    height: getScreenSize(context).height,
                    width: getScreenSize(context).width,
                    child: GridView.builder(
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap:true,
                        gridDelegate: const  SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 6,
                            crossAxisSpacing: 3,
                            mainAxisExtent: 290,
                            childAspectRatio: 1

                        ),
                        itemBuilder: (context,index){
                         { 
                           return InkWell(
                            onTap: (){
                              NavigatorTo(context,  ProductDetailScreen(

                                  Productprice: snapshot.data!.docs[index]['price'],
                                  Producttype: snapshot.data!.docs[index]['type'],
                                  Productname: snapshot.data!.docs[index]['name'],
                                  ProductimagePath:snapshot.data!.docs[index]['images'],
                                  Size: snapshot.data!.docs[index]['sizes'],
                                  Productdescription: snapshot.data!.docs[index]['description'],
                                  ProductReviews: snapshot.data!.docs[index]['reviews'],
                                  ProductId: snapshot.data!.docs[index]['ProductId']

                              ));


                            },
                            child: Consumer<WishlistProvider>(

                              builder: (BuildContext context, WishlistProvider value, Widget? child) {
                                return  NewArrivalTile(
                                  image: snapshot.data!.docs[index]['images'],
                                  description: snapshot.data!.docs[index]['description'],
                                  type:snapshot.data!.docs[index]['type'],
                                  price: snapshot.data!.docs[index]['price'],
                                  productId:snapshot.data!.docs[index]['ProductId'].toString(),
                                  position: index,
                                  name: snapshot.data!.docs[index]['name'],
                                  Size:  snapshot.data!.docs[index]['sizes'],
                                  reviews:  snapshot.data!.docs[index]['reviews'],
                                  brand:  snapshot.data!.docs[index]['brand'],);
                              },
                            ),

                          );
                          }
                        }
                        )
                    )
              ],
            ),
          );}})
        ),
      ),
    );
  }
}
