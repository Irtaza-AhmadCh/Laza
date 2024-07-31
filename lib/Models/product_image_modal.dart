import 'package:laza/Resources/Paths/AssetsPath.dart';

class ProductImageModal{
  String imagePath;
  ProductImageModal({required this.imagePath});
}


List<ProductImageModal> ProductImageList = [
  ProductImageModal(imagePath: PngImages.shirt),
  ProductImageModal(imagePath: PngImages.shirt),
  ProductImageModal(imagePath: PngImages.jaket),
];