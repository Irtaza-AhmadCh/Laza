import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laza/Firebase/DataBase/User_data/get_user_data.dart';
import 'package:laza/Models/choose_brand_model.dart';
import 'package:laza/Providers/home-provider.dart';
import 'package:laza/Providers/search_provider.dart';
import 'package:laza/Providers/wishList_provider.dart';
import 'package:laza/Resources/Colors/Colors.dart';
import 'package:laza/Resources/NavigationBar/nav_bar.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/Paths/imports.dart';
import 'package:laza/Resources/Widgets/choose_brand.dart';
import 'package:laza/Resources/Widgets/drawer.dart';
import 'package:laza/Resources/Widgets/drawerTile.dart';
import 'package:laza/Resources/Widgets/new_arrival_tile.dart';
import 'package:laza/Veiw/all_brands.dart';
import 'package:laza/Veiw/shoping_screen/all_arrival_screen.dart';
import 'package:laza/Veiw/cart_screen.dart';
import 'package:laza/Veiw/favirate_list_screen.dart';
import 'package:laza/Veiw/auth_screens/login_screen.dart';
import 'package:laza/Veiw/payment_screen.dart';
import 'package:laza/Veiw/product_detail_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:switcher_button/switcher_button.dart';
import '../Firebase/Auth/logout_auth.dart';
import '../Models/new_arrival_model.dart';
import '../Providers/reviw_provider.dart';
import '../Providers/theme_provider.dart';
import '../Resources/MediaQuery/media_query.dart';
import '../Resources/Paths/AssetsPath.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();


}

 late final userData;

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
class _HomeScreenState extends State<HomeScreen> {
  TextEditingController seacrhController = TextEditingController();
  SpeechToText _speechToText = SpeechToText();
  final snapshotRef = FirebaseFirestore.instance.collection('Products').snapshots();
  bool _speechEnabled = false;
  String _lastWords = '';
  List allresult = [];
  List searchresult = [];
  late Future futureResult ;

 getBrandList()async {
if( seacrhController.text.isNotEmpty){
  var products = await FirebaseFirestore.instance.collection('Products')
      .where('type'.toString().split(''),isLessThanOrEqualTo: seacrhController.text.toString().toLowerCase()).orderBy('type').get();
  print(seacrhController.text.toString());
}else{

}


}

  @override
  void initState() {
    super.initState();
    _initSpeech();
    UserData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    seacrhController.dispose();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
seacrhController.text =_lastWords;
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    print("result $_lastWords is");
    seacrhController.text =_lastWords.toString();
    setState(() {});
  }

  final _auth = FirebaseAuth.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>> UserData() async {
    final String userId = _auth.currentUser!.uid.toString();
    final userRef = FirebaseFirestore.instance.collection('User').doc(userId);
    final docSnapshot = await userRef.get();
    return docSnapshot;
  }



  @override
  Widget build(BuildContext context) {

    final themeprovider = Provider.of<ThemeProvider>(context);
    final searchprovider = Provider.of<SearchProvider>(context);
    final homeProvider = Provider.of<HomeScreenProvvider>(context ,listen: false);
    homeProvider.getProduct();
    // final reviewProvider = Provider.of<ReviewProvider>(context);
    // reviewProvider.getReviews();
    final w  =getScreenSize(context).width*(1/375);
    final h= getScreenSize(context).height*(1/812);

    return  SafeArea(child:
    Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: MyColor.white,
        foregroundColor: MyColor.white,
        surfaceTintColor: Colors.white,
        toolbarHeight: 90,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: InkWell(
              focusColor: Colors.transparent,
              hoverColor:Colors.transparent,
              highlightColor:Colors.transparent,
              splashColor:Colors.transparent,
              onTap: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              child: SvgPicture.asset(Images.menu)),
        ),
        actions: [
          InkWell(
            onTap: (){
              navigatedFrom = '';
              NavigatorTo(context, const CartScreen());

            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SvgPicture.asset(Images.cart),
            ),
          ),
          const SizedBox(width: 20,)        ],
      ),
      drawer:  Drawer(
        backgroundColor: MyColor.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 45),
          child: Column(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                          focusColor: Colors.transparent,
                          splashColor:Colors.transparent,
                          hoverColor:Colors.transparent,
                          highlightColor:Colors.transparent,
                          onTap: (){
                            NavigatorPop(context);
                          },

                          child: Image.asset(PngImages.closeMenu,))
                    ],
                  ),
                  const SizedBox(height: 30,),
                  FutureBuilder<DocumentSnapshot<Map<String, dynamic>>> (
                    future: UserData(),
                    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
                      if(snapshot.hasError){
                        return   const Center(
                          child:    Text('No Data found', style: TextStyle(
                            color: MyColor.textBlack,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600 ,
                            fontSize: 17,
                          ),),
                        );
                      }else
                        if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(
                            child:   LoadingAnimationWidget.stretchedDots(color: MyColor.purple, size: 20)
                        );

                      }else{
                      return Row(
                        children: [
                          Container(
                            height:45 ,
                            width: 45,
                            decoration: BoxDecoration(
                              border: Border.all(color: MyColor.grey, ),
                              color: MyColor.grey,
                              shape: BoxShape.circle,
                              image:  DecorationImage(image: NetworkImage(snapshot.data!.data()!['profileImage'],),
                                fit: BoxFit.fill
                            ),
                          ),),
                          const SizedBox(width: 5,),
                           Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text( snapshot.data!.data()!['Name'],
                                style: const TextStyle(
                                color: MyColor.textBlack,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600 ,
                                fontSize: 17,
                              ),),
                              const Row(
                                children: [

                                  Text('Verified Profile', style: TextStyle(
                                    color: MyColor.textLight,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400 ,
                                    fontSize: 13,
                                  ),),
                                  Icon(Icons.verified, color: MyColor.green, size: 15,)

                                ],
                              )
                            ],
                          )
                        ],
                      );}
                    },
                  ),
                  const SizedBox(height: 30,),
                  DrawerTile(lable: 'Dark Mode', icon: PngImages.sun, modechanger:
                  Consumer<ThemeProvider>(
                    builder: ( context,  value,  child) {
                      return Container(
                          decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: MyColor.textLight,
                                width: 1,
                              )),
                          height: 18,
                          width: 33,
                          child: SwitcherButton(
                            value: true,
                            onChange: (val) {
                              value.themeChanger(val);
                              print(val);
                            },
                          ));
                    },),),
                  // const DrawerTile(lable: 'Account Information', icon: PngImages.infoCircle, ),

                  DrawerTile(
                      ontap: (){
                        NavigatorTo(context, const CartScreen());
                      },
                      lable: 'Order', icon: PngImages.bag),
                  DrawerTile(

                      ontap:(){   navigatedFrom = '';
                      NavigatorTo(context, const PaymentScreen());},lable: 'My Cards', icon: PngImages.card),
                  DrawerTile(
                      ontap: (){
                        navigatedFrom = '';
                        NavigatorTo(context, const FavirateListScreen());
                      },
                      lable: 'Wishlist', icon: PngImages.heartpng),

                ],
              ),

              InkWell(
                  onTap: (){
                    logoutAuth(context);
                  },
                  child:  const SizedBox(
                    height: 45,
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: MyColor.red,),
                        SizedBox(width: 5,),
                        Text('Logout' ,style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: MyColor.red,
                            fontFamily: 'Inter'
                        ),),
                      ],
                    ),
                  )
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Hello', style: TextStyle(
                      color: MyColor.textBlack,
                      fontSize: 28,
                      fontWeight:FontWeight.w600 ,
                      fontFamily: 'Inter',
                    ),),
                    const Text('Welcome to Laza.', style: TextStyle(
                      color: MyColor.textLight,
                      fontSize: 15,
                      fontWeight:FontWeight.w400 ,
                      fontFamily: 'Inter',
                    ),),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: getScreenSize(context).width,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: TextFormField(
                      controller:seacrhController,
                              onChanged: (val){
                        homeProvider.search(val.toString().toLowerCase());
                              },
                              decoration: InputDecoration(
                                  hintText: 'Search...',
                                  hintStyle:  const TextStyle(
                                    color: MyColor.textLight,
                                    fontSize: 15,
                                    fontWeight:FontWeight.w400 ,
                                    fontFamily: 'Inter',
                                  ),
                                  filled: true,
                                  fillColor:const Color(0xffF5F6FA),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: MyColor.grey
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: MyColor.grey
                                      )
                                  ),
                                  prefixIcon:
                                  Padding(
                                    padding: const EdgeInsets.only(top: 17,bottom: 17,left: 17),
                                        child: SvgPicture.asset(Images.search,)
                                  )
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: (){
                              (_speechToText.isNotListening) ?_startListening()
                                  :
                              {
                                _stopListening(),
                                homeProvider.search(_lastWords.toString().toLowerCase())

                              };
                              print('tap');
                              setState(() {

                              });
                            },
                            child: Container(
                              height:50 ,
                              width: 50,
                              padding:const EdgeInsets.all(13) ,
                              decoration: BoxDecoration(

                                color: MyColor.purple,
                                borderRadius: BorderRadius.circular(10),
                              ),child:(_speechToText.isListening)? SvgPicture.asset(Images.voice,height: 25,width: 25,): const Icon(Icons.mic_off, color: MyColor.white,),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Choose Brand', style: TextStyle(
                        color:MyColor.textBlack ,
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        fontFamily: 'Inter'
                    ),),
                    InkWell(
                      onTap: (){
                        NavigatorTo(context, AllBrandScreen());
                      },
                      child: const Text('View all', style: TextStyle(
                          color:MyColor.textLight ,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          fontFamily: 'Inter'
                      ),),
                    )
                  ],
                ),
                const SizedBox(
                    height: 15
                ),
                SizedBox(
                  height: 50,
                  child:StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('Brands').snapshots(),
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
    }else{return  ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index){
                        return  ChooseBrandTile(brandName: snapshot.data!.docs[index]['BrandName'], brandLogo: snapshot.data!.docs[index]['BrandLogo']);
                      });}}),
                ),
                const SizedBox(
                  height: 15,
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('New Arraival', style: TextStyle(
                        color:MyColor.textBlack ,
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        fontFamily: 'Inter'
                    ),),
                    InkWell(
                      onTap: (){
                        NavigatorTo(context, const AllArrivalScreen());
                      },

                      child: const Text('View all', style: TextStyle(
                          color:MyColor.textLight ,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          fontFamily: 'Inter'
                      ),),
                    )
                  ],
                ),
                SizedBox(
                    height: getScreenSize(context).height -300,
                    width: getScreenSize(context).width,
                    child:

                            Consumer<HomeScreenProvvider>(
                            builder: (context, homevalue, chlid) {
                           List<NewArrivalModel> data = homevalue.productdata;
                              return (data.isNotEmpty)? GridView.builder(
                                  itemCount: data.length,
                                  gridDelegate: const  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 6,
                                      crossAxisSpacing: 3,
                                      mainAxisExtent: 290,
                                      childAspectRatio: 1

                                  ),
                                  itemBuilder: (context,index){

                                    return  InkWell(
                                        onTap: () {
                                          NavigatorTo(
                                              context,
                                              ProductDetailScreen(
                                                  Productprice: data[index].Productprice,
                                                  Producttype: data[index].Producttype,
                                                  Productname:data[index].Productname,
                                                  ProductimagePath:data[index].ProductimagePath,
                                                  Size: data[index].Size,
                                                  Productdescription:data[index].Productdescription,
                                                  ProductReviews: data[index].Reviews,
                                                  ProductId: data[index].ProductId,));
                                        },
                                        child: Consumer<WishlistProvider>(
                                          builder: (BuildContext context,
                                              WishlistProvider value,
                                              Widget? child) {
                                            print(data[index].Productname);
                                            return NewArrivalTile(
                                              image: data[index].ProductimagePath,
                                              description:  data[index].Productdescription,
                                              type:  data[index].Producttype,
                                              price:  data[index].Productprice,
                                              productId:  data[index].ProductId,
                                              position: index,
                                              name: data[index].Productname,
                                              Size: data[index].Size,
                                              reviews: data[index].Reviews,
                                              brand: data[index].ProductBrand,
                                            );
                                          },
                                        ),
                                      );
                                  }): Center(
                                child: Text('No Product Founded 🤷‍♂️' ,style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'Inter',
                                  color: MyColor.red
                                ),),
                              );
                            }
                          )

                )


              ]

          ),
        ),
      ),
    ));
  }
}
