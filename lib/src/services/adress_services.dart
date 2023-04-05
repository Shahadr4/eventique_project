import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/AdressModel.dart';

class AdressServices {

   Future<List<Adress>> getAdress(String uid) async {
    CollectionReference firbase =FirebaseFirestore.instance.collection("users").doc(uid).collection('adress');
    return firbase.get().then((value) {
      List<Adress> adressList = [];
      for (DocumentSnapshot adress in value.docs) {
        adressList.add(Adress.fromjson(adress));
      }
      return adressList;
    });
  }


}