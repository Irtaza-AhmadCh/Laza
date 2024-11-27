

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/NotificationMassage/ToastMassage.dart';
import 'package:laza/Veiw/reviews_screen.dart';

import '../../../Models/review_model.dart';

final databaseRef = FirebaseFirestore.instance.collection('Products');

addReview(productId,name, review, rating, context )async{
  final mapData = {
    'name': name,
    'review': review,
    'rating': rating,
    'time': '${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}'
  };
  final ListData = [mapData];

  await databaseRef.doc(productId.toString()).update({
      'reviews': FieldValue.arrayUnion(ListData)
    }).then((_){
      Toastmassage.SuccessToast('Review add success');
      NavigatorPop(context);
  }).onError((error, stackTrace){
    Toastmassage.ErrorToast(error);
  });


}
