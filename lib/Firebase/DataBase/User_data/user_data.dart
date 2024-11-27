
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:laza/Resources/NotificationMassage/ToastMassage.dart';

final firebaseRef = FirebaseFirestore.instance.collection('User');
 final _auth = FirebaseAuth.instance;


UserData(name, email ,File? image){
  firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance.ref('/ProfileImages/${_auth
      .currentUser!.uid.toString()}');
  firebase_storage.UploadTask uploadTask = storageRef.putFile(image!.absolute);



  Future.value(uploadTask).then((val)async{
    var imageUrl = await storageRef.getDownloadURL();

    firebaseRef.doc(_auth.currentUser!.uid.toString()).set({
      'Name' : name,
      'Id':_auth.currentUser!.uid.toString(),
      'Email' : email,
      'profileImage': imageUrl
    }).then((_){
      Toastmassage.SuccessToast('Data Added');

    }).onError((error, stackTrace){
      Toastmassage.ErrorToast(error);
    });




  }).onError((error,stackTrace){
Toastmassage.ErrorToast(error);
  });

}