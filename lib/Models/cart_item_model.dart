import 'package:laza/Resources/Paths/AssetsPath.dart';

class CartItemModel{
  String desciption;
  String price;
  String imagePath;
  int quantity;
  CartItemModel({required this.imagePath, required this.price, required this.desciption,required this.quantity});
}


List<CartItemModel> cartItems =[
  CartItemModel(imagePath: PngImages.shirt, price: '\$44', desciption: """Men's Tie-Dye T-ShirtNike Sportswear""", quantity: 1),
  CartItemModel(imagePath: PngImages.shirt, price: '\$55', desciption: """Men's Printed Pullover Hoodie""", quantity: 1),
  CartItemModel(imagePath: PngImages.shirt, price: '\$90', desciption: """Men's Tie-Dye T-ShirtNike Sportswear""" , quantity: 1),
];