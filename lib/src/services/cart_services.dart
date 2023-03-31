import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final user = FirebaseAuth.instance.currentUser!;
CollectionReference cartCollection = FirebaseFirestore.instance
    .collection("users")
    .doc(user.uid)
    .collection("cart");

class CartServices {




  
  Future<double> calculateTotalPrice() async {
    double totalPrice = 0;
    QuerySnapshot querySnapshot = await cartCollection.get();
    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      totalPrice += documentSnapshot['price'];
    }

    return double.parse(totalPrice.toStringAsFixed(2));
  }

  Future<void> clearCollection() async {
    final QuerySnapshot querySnapshot = await cartCollection.get();
    final List<DocumentSnapshot> documents = querySnapshot.docs;
    for (DocumentSnapshot document in documents) {
      await document.reference.delete();
    }
  }
}
