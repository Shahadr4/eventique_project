import 'package:flutter/material.dart';

class Product{
  final String image,title;
  final String price;
 

  Product({required this.title,required this.image,required this.price,});
}


// ignore: non_constant_identifier_names
List<Product>list_Product=[ 

  Product(title: "Grey Full Sleeves Shirts", image:"https://imagescdn.allensolly.com/img/app/product/8/863740-10207643.jpg?q=75&auto=format&w=342", price: "1,999"),
  Product(title:"Full Sleeves Casual Shirts" , image: "https://imagescdn.allensolly.com/img/app/product/8/863739-10207621.jpg?q=75&auto=format&w=342", price: "1,699"),
  Product(title: "Men White Solid Crew Neck T-Shirt", image: "https://imagescdn.allensolly.com/img/app/product/7/712223-7801991.jpg?q=75&auto=format&w=342", price: "6,48"),
  Product(title: "Men Grey Slim Fit Solid Casual Trousers", image: "https://imagescdn.allensolly.com/img/app/product/8/859809-10145082.jpg?q=75&auto=format&w=342", price:"2,499"),
  Product(title: "Men Brown Lace-Up Lace Up Shoes", image: "https://imagescdn.allensolly.com/img/app/product/8/806265-9567092.jpg?q=75&auto=format&w=342", price: "1,779")
  
];