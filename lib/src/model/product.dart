

import 'package:cloud_firestore/cloud_firestore.dart';




class Product {

  String image;
  String title;
  double price;
  bool? isFavorite;
  String? size;

  String gender;
  String description;
  
  
  // List<String> keywords;
 
  Product({
    required this.title, 
    required this.image,
    required this.price,
    this.isFavorite = false,
    this.size,
  
    
    required this.gender,
    required this.description

    
    // required this.keywords
  });

  factory Product.fromFirestore(DocumentSnapshot data) {
    return Product(
      title: data['title'] ?? '',
      image: data['image'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
     
      gender: data['gender'] ,
      description: data['description']??'',
      

      
      // keywords:   List<String>.from(data['keyword'])  
    );
  }
}  