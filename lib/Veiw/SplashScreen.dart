import 'dart:async';
import 'package:laza/Resources/Navigators/navigators.dart';

import '../Resources/Paths/AssetsPath.dart';
import '../Resources/Paths/imports.dart';
import 'shoping_screen/gender_selection_screen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(const Duration(seconds: 3),
        ()=>NavigatorToReplace(context, const GenderSelectionScreen())
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: MyColor.purple,
      body: Center(

        child: SvgPicture.asset(Images.logo, height: 36, width: 59,),
      ),
    );

  }
}
