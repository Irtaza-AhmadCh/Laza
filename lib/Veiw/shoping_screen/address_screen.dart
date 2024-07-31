import 'package:laza/Resources/MediaQuery/media_query.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/Widgets/reuseable_appbar.dart';
import 'package:laza/Resources/Widgets/reuseable_textfield.dart';
import 'package:laza/Veiw/cart_screen.dart';
import 'package:switcher_button/switcher_button.dart';

import '../../Resources/Paths/imports.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {

    TextEditingController nameController = TextEditingController();
    TextEditingController countryController = TextEditingController();
    TextEditingController cityController = TextEditingController();
    TextEditingController phoneNoController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    final w = getScreenSize(context).width * (1 / 375);
    final h = getScreenSize(context).height * (1 / 812);

    return  SafeArea(
      child: Scaffold(
        appBar: appBar(context, title: 'Address'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: [
                    ReuseableTextfield(title: 'Name', controller: nameController, hint: 'Ali'),
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        SizedBox(
                          width: getScreenSize(context).width/2 - 28,
                            child: ReuseableTextfield(title: 'Country', controller: countryController, hint: 'Pakistan')),
                       SizedBox(width: 15,),
                        SizedBox(
                            width: getScreenSize(context).width/2 -28,
                
                            child: ReuseableTextfield(title: 'City', controller: cityController, hint: 'Sahiwal'))
                      ],
                    ),
                    SizedBox(height: 15,),
                    ReuseableTextfield(title: 'Phone Number', controller: phoneNoController, hint: '0330 23456788'),
                    SizedBox(height: 15,),
                    ReuseableTextfield(title: 'Address', controller: addressController, hint: 'Kalma Garden'),
                    SizedBox(height: 25,),
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
                  ],
                ),
              ),
              SizedBox(height: 216*h,),
              BottomButtons(lable: 'Save Address', ontap: (){
                NavigatorPop(context);
              })
            ],
          ),
        ),
      ),
    );
  }
}
