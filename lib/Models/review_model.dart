class ReviewModel{
  String name;
  String reveiw;
  double ratings;
  ReviewModel({required this.ratings, required this.name, required this.reveiw});
}

List<ReviewModel> reveiwList = [
  ReviewModel(ratings: 4, name: 'Irtaza', reveiw: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet...'),

];