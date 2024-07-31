import 'package:laza/Resources/Paths/AssetsPath.dart';

class NewArrivalModel{
  String ProductimagePath;
  String Productname;
  String Producttype;
  String Productprice;
  NewArrivalModel({required this.ProductimagePath, required this.Productname, required this.Productprice, required this.Producttype});
}

List<NewArrivalModel> NewArrivalList = [
  NewArrivalModel(ProductimagePath: PngImages.shirt,
      Productname: 'Nike Sportswear Club',
      Productprice: '99',
      Producttype: 'Fleece'),
  NewArrivalModel(ProductimagePath: PngImages.shirt,
      Productname: 'Nike Sportswear Club',
      Productprice: '99',
      Producttype: 'Fleece'),
  NewArrivalModel(ProductimagePath: PngImages.shirt,
      Productname: 'Nike Sportswear Club',
      Productprice: '99',
      Producttype: 'Fleece'),
  NewArrivalModel(ProductimagePath: PngImages.shirt,
      Productname: 'Nike Sportswear Club',
      Productprice: '99',
      Producttype: 'Fleece'),
  NewArrivalModel(ProductimagePath: PngImages.shirt,
      Productname: 'Nike Sportswear Club',
      Productprice: '99',
      Producttype: 'Fleece'),
  ];