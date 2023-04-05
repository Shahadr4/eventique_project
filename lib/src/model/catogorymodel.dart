import 'package:cloud_firestore/cloud_firestore.dart';
 

class CatogoryName {
  String title;
  String image;

  CatogoryName({required this.title, required this.image});
  factory CatogoryName.fromFirestore(DocumentSnapshot data) {
    return CatogoryName(
      title: data['title'] ?? '',
      image: data['image'] ?? '',
       
    );
  }


}
