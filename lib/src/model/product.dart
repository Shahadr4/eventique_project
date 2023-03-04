import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'product.g.dart'; 



@HiveType(typeId: 1)
class Product {
  @HiveField(0)
  String image;
  @HiveField(1)
  String title;
  @HiveField(2)
  double price;

  Product({
    required this.title,
    required this.image,
    required this.price,
  });

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




