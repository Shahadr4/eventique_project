import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventique/src/model/cartModel.dart';
import 'package:eventique/src/model/product.dart';

class OderModel {
  List<Map<String, dynamic>> carted;

  String price;
  String name;
  String uid;
  Timestamp createdAt;
  int number;

  OderModel({
    required this.carted,
    required this.price,
    required this.name,
    required this.uid,
    required this.createdAt,
    required this.number
  });

  factory OderModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> data) {
    return OderModel(
      carted: List<Map<String, dynamic>>.from(data.data()!['carted']),   
      price: data['price'],
      name: data['name'],
      uid: data['uid'],
      createdAt: data['create at'],
      number: data['number']
    );
  }
}
