import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laza/Models/choose_brand_model.dart';
import 'package:laza/Resources/Colors/Colors.dart';
import 'package:laza/Resources/NavigationBar/nav_bar.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/Paths/imports.dart';
import 'package:laza/Resources/Widgets/choose_brand.dart';
import 'package:laza/Resources/Widgets/drawer.dart';
import 'package:laza/Resources/Widgets/drawerTile.dart';
import 'package:laza/Resources/Widgets/new_arrival_tile.dart';
import 'package:laza/Veiw/shoping_screen/all_arrival_screen.dart';
import 'package:laza/Veiw/cart_screen.dart';
import 'package:laza/Veiw/favirate_list_screen.dart';
import 'package:laza/Veiw/auth_screens/login_screen.dart';
import 'package:laza/Veiw/payment_screen.dart';
import 'package:laza/Veiw/product_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:switcher_button/switcher_button.dart';
import '../Firebase/Auth/logout_auth.dart';
import '../Models/new_arrival_model.dart';
import '../Providers/theme_provider.dart';
import '../Resources/MediaQuery/media_query.dart';
import '../Resources/Paths/AssetsPath.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();


}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
class _HomeScreenState extends State<HomeScreen> {
  TextEditingController seacrhController = TextEditingController();
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';


  @override
  void initState() {
    super.initState();
    _initSpeech();
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

  @override
  Widget build(BuildContext context) {
    final themeprovider = Provider.of<ThemeProvider>(context);
    final w  =getScreenSize(context).width*(1/375);
    final h= getScreenSize(context).height*(1/812);

    return  SafeArea(child:
    Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: MyColor.white,
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
          child: ListView(

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
                  Row(
                    children: [
                      Container(
                        height:45 ,
                        width: 45,
                        decoration: BoxDecoration(
                          border: Border.all(color: MyColor.grey, ),
                          color: MyColor.grey,
                          shape: BoxShape.circle,
                          image: const DecorationImage(image: AssetImage(PngImages.shirt)),
                        ),
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Irtaza', style: TextStyle(
                            color: MyColor.textBlack,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600 ,
                            fontSize: 17,
                          ),),
                          Row(
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
                        navigatedFrom = '';
                        NavigatorTo(context, const CartScreen());
                      },
                      lable: 'Password', icon: PngImages.lock),
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
                  const DrawerTile(lable: 'Settings', icon: PngImages.setting),
                ],
              ),
              SizedBox(height: 144*h,),
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
                              (_speechToText.isNotListening) ?_startListening() :_stopListening();
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Choose Brand', style: TextStyle(
                        color:MyColor.textBlack ,
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        fontFamily: 'Inter'
                    ),),
                    Text('View all', style: TextStyle(
                        color:MyColor.textLight ,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        fontFamily: 'Inter'
                    ),)
                  ],
                ),
                const SizedBox(
                    height: 15
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: brandList.length,
                      itemBuilder: (context, index){
                        return ChooseBrandTile(brandName: brandList[index].brandName, brandLogo: brandList[index].imagePath);
                      }),
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
                    height: getScreenSize(context).height -60,
                    width: getScreenSize(context).width,
                    child: GridView.builder(
                        itemCount: NewArrivalList.length,
                        shrinkWrap:true,
                        gridDelegate: const  SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 6,
                            crossAxisSpacing: 3,
                            mainAxisExtent: 270,
                            childAspectRatio: 1

                        ),
                        itemBuilder: (context,index){
                          return InkWell(
                            onTap: (){
                              NavigatorTo(context, const ProductDetailScreen());                            },
                            child: NewArrivalTile(image: NewArrivalList[index].ProductimagePath,
                                name: NewArrivalList[index].Productname,
                                type: NewArrivalList[index].Producttype,
                                price: NewArrivalList[index].Productprice),
                          );
                        })
                )


              ]

          ),
        ),
      ),
    ));
  }
}
