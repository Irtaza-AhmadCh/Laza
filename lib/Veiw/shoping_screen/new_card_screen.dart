import 'package:laza/Models/card_type_model.dart';
import 'package:laza/Providers/card-type-provider.dart';
import 'package:laza/Resources/Widgets/reuseable_appbar.dart';
import 'package:laza/Resources/Widgets/reuseable_textfield.dart';
import 'package:provider/provider.dart';

import '../../Resources/MediaQuery/media_query.dart';
import '../../Resources/Paths/AssetsPath.dart';
import '../../Resources/Paths/imports.dart';

class NewCardScreen extends StatefulWidget {
  const NewCardScreen({super.key});

  @override
  State<NewCardScreen> createState() => _NewCardScreenState();
}

class _NewCardScreenState extends State<NewCardScreen> {
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
                        height: 50,
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
                                        value.selectedSize(index);

                                      },
                                      child: Container(
                                        height: 50,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: (value.selectedIndex == index)? Color(0xffFFEEE3): MyColor.grey,
                                          border: Border.all(color:(value.selectedIndex == index)? Color(0xffFF5F00): MyColor.grey,),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(cardTypeList[index].cardLogoPath,),
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

                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomButtons(lable: 'Add Card', ontap: (){}),
    ));
  }
}