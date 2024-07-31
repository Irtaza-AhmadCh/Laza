

import 'package:fluttertoast/fluttertoast.dart';

import '../Paths/imports.dart';

class Toastmassage{

static SuccessToast(msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 3,
      backgroundColor: MyColor.green,
      textColor: Colors.white,
      fontSize: 16.0,
      webPosition: "center"

  );
}

static ErrorToast(error) {
  Fluttertoast.showToast(
      msg: error,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 3,
      backgroundColor: MyColor.red,
      textColor: Colors.white,
      fontSize: 16.0,
      webPosition: "center"

  );
}

static GeneralToast(msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 3,
      backgroundColor: MyColor.purple,
      textColor: Colors.white,
      fontSize: 16.0,
      webPosition: "center"

  );
}}