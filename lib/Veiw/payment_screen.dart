import 'package:laza/Models/card_type_model.dart';
import 'package:laza/Providers/card-type-provider.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/Widgets/reuseable_appbar.dart';
import 'package:laza/Resources/Widgets/reuseable_textfield.dart';
import 'package:laza/Veiw/cart_screen.dart';
import 'package:laza/Veiw/shoping_screen/new_card_screen.dart';
import 'package:provider/provider.dart';
import 'package:switcher_button/switcher_button.dart';

import '../Resources/MediaQuery/media_query.dart';
import '../Resources/Paths/AssetsPath.dart';
import '../Resources/Paths/imports.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController cardOwnerController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardExpController = TextEditingController();
  TextEditingController cardCVVController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final w = getScreenSize(context).width * (1 / 375);
    final h = getScreenSize(context).height * (1 / 812);

    return  SafeArea(child:Scaffold(
      appBar: appBar(context, title: 'Payment'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Container(
                        height: 185,
                        child: Consumer<CardTypeProvider>(
                          builder: (context, value, child){
                            return ListView.builder(
                                itemCount: cardTypeList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context ,index){
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: InkWell(
                                      onTap: (){
                                      },
                                      child: Container(
                                        height: 185,
                                        width: 300,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(image: AssetImage(PngImages.paymentCard),),
                                          color: MyColor.grey,
                                          border: Border.all(color: MyColor.grey,),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });

                          },

                        ),
                      ),
                      SizedBox(height: 15,),
                      InkWell(
                        onTap: (){
                          NavigatorTo(context, NewCardScreen());
                        },
                        child: Container(
                          height: 50,
                          width: 335*w,
                          decoration: BoxDecoration(
                            color: Color(0xffF6F2FF),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: MyColor.purple,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_box_outlined, color:  MyColor.purple,size: 20,),
                              SizedBox(width: 5,),
                              Text('Add new card', style: TextStyle(
                                color: MyColor.purple,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter',
                              ),)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      
                      ReuseableTextfield(title: 'Card Owner', controller: cardOwnerController, hint: 'Ali'),
                      SizedBox(height: 15,),
                      ReuseableTextfield(title: 'Card Number', controller: cardNumberController, hint: '5254 7634 8734 7690'),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          SizedBox(
                            width:getScreenSize(context).width/2-28,
                              child: ReuseableTextfield(title: 'Exp', controller: cardExpController, hint: '24/24')),
                         SizedBox(width: 15,),
                          SizedBox(
                            width: getScreenSize(context).width/2-28,
                              child: ReuseableTextfield(title: 'CVV', controller: cardCVVController, hint: '2345')),
                        ],
                      ),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Save as primary address',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: MyColor.textBlack,
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: MyColor.textLight,
                                    width: 1,
                                  )),
                              height: 25,
                              width: 45,
                              child: SwitcherButton(
                                offColor: MyColor.white,
                                onColor: MyColor.green,
                                value: true,
                                onChange: (value) {},
                              )),

                        ],
                      ),
                      SizedBox(height: 15,),
        
                    ],
                  ),
                ),
                BottomButtons(lable: 'Save Card', ontap: (){
                  NavigatorPop(context);
                }),
              ],
            )
          ],
        ),
      ),
    ));
  }
}