import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class CartedModel{
  String name;
  String image; 
  double price;
  String size;
  
  

  CartedModel({required this.image,required this.name,required this.price,required this.size,});

  factory CartedModel.fromFirestore(DocumentSnapshot snapshot){
    return CartedModel(image: snapshot['image']??"", name: snapshot['name']??"", price:(snapshot['price'] ?? 0.0).toDouble(), size: snapshot['size']??"",);
  }

    Map<String, dynamic> toJson() => {
        'name': name,
        'image':image,
        'price':price,
        'size':size
      };
} 