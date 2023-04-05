import 'package:cloud_firestore/cloud_firestore.dart';

class Adress{
   
  final String houseName;
  final String state;
  final String postpin;
  final String city;


  Adress({required this.houseName,required this.state,required this.postpin,required this.city});

  factory Adress.fromjson(DocumentSnapshot json) =>Adress(houseName:json['housename'], state:json['state'], postpin:json['pin'], city:json['city']);
  
} 