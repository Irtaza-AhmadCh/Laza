import '../Resources/Paths/AssetsPath.dart';

class CardTypeModel{
  String cardLogoPath;
  String cardType;
  CardTypeModel({required this.cardLogoPath,required this.cardType});
}

List<CardTypeModel> cardTypeList = [

  CardTypeModel(cardLogoPath: PngImages.bank, cardType: 'Bank Card'),
  CardTypeModel(cardLogoPath: PngImages.paypal, cardType: 'Paypal'),
  CardTypeModel(cardLogoPath: PngImages.master, cardType: 'Master Card'),

];