import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laza/Resources/NotificationMassage/ToastMassage.dart';
import 'package:provider/provider.dart';

import '../../Providers/bottom_buttom_provider.dart';
import '../../Resources/Navigators/navigators.dart';
import '../../Resources/Paths/imports.dart';

final databaseRef = FirebaseFirestore.instance.collection('User');
final _auth = FirebaseAuth.instance;


 addCard( {ownername,cardNo,exp,cvv,type,context ,}){
  final cartMap = {
    'name': ownername,
    'cardNo': cardNo,
    'exp': exp,
    'cvv': cvv,
    'cardType': type,
  };

  List cartDataList =[cartMap];
  databaseRef.doc(_auth.currentUser!.uid).update({
    'Cards' : FieldValue.arrayUnion(cartDataList) ,
  }).then((_){
    Provider.of<BottomButtomProvider>(context, listen:  false).endloading();
    Toastmassage.SuccessToast('Cart added');
    NavigatorPop(context);
  
  }).onError((error,stackTrace){
    Provider.of<BottomButtomProvider>(context, listen:  false).endloading();
    Toastmassage.ErrorToast(error);
  });



}

