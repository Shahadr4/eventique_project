import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventique/src/model/cartModel.dart';

class CartedServices{

FirebaseFirestore firstore = FirebaseFirestore.instance;

    
  Future<List<CartedModel>> getCategories(String uid) async {
    return firstore.collection('users').doc(uid).collection("cart").get().then((value) {
      List<CartedModel> cartedList = [];
      for (DocumentSnapshot carted in value.docs) {
        cartedList.add(CartedModel.fromFirestore(carted));
      }
      return cartedList;
    });
  }


}  