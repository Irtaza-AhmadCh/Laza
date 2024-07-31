import 'package:provider/provider.dart';

import '../../Providers/gender_provider.dart';
import '../../Veiw/auth_screens/CreateAccountScreen.dart';
import '../MediaQuery/media_query.dart';
import '../NavigationBar/nav_bar.dart';
import '../Navigators/navigators.dart';
import '../Paths/imports.dart';


appBar(context,{title} ){
  return AppBar(
    title: Text(
      title,
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
    leading: (navigatedFrom == 'navBar')? Text(''):Padding(
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
  );
}

