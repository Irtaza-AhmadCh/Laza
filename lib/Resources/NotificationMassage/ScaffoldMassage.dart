

import '../Paths/imports.dart';

class Scaffoldmassage {

static massage(context ,massage){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(massage)));
}




}
