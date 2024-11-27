import 'package:laza/Resources/Paths/AssetsPath.dart';

import '../Resources/Paths/AssetsPath.dart';

class CartProductModel{
  final List image;
  final String description;
  final String type;
  final int price;

  CartProductModel( {required this.image, required this.description, required this.type, required this.price});
}
