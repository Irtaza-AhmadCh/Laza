import 'package:flutter/material.dart';

class GenderProvider extends ChangeNotifier{
  bool selectedman = true;
  bool selectedwoman = true;
  change(){

    notifyListeners();
  }
}