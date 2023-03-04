import 'package:flutter/material.dart';

class Product{
   String image,title;
  double price;
 
 

  Product({required this.title,required this.image,required this.price,});
  
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
      'price': price,
    };
  }
   factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      title: map['title'],
      image: map['image'],
      price: map['price'],
    );
  }
}





