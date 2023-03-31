

import 'package:cloud_firestore/cloud_firestore.dart';




class Product {

  String image;
  String title;
  double price;
  bool? isFavorite; 
  String? size;
  bool popular;
  
  // List<String> keywords;
 
  Product({
    required this.title, 
    required this.image,
    required this.price,
    this.isFavorite = false,
    this.size,
    required this.popular
    // required this.keywords
  });

  factory Product.fromFirestore(DocumentSnapshot data) {
    return Product(
      title: data['title'] ?? '',
      image: data['image'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      popular:data['popular'] ?? false,
      
      // keywords:   List<String>.from(data['keyword'])  
    );
  }
}  