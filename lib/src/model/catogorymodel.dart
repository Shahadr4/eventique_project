import 'package:flutter/material.dart';

class Catogory{
   String title;
   String image;

  Catogory({required this.title,required this.image});
  // ignore: non_constant_identifier_names

}
  List<Catogory>list_catogory =[
    Catogory(title: "Shirts",image: "https://cdn.shopify.com/s/files/1/0752/6435/products/IMG_0015_a1da1c4d-32a3-4543-8796-3f24f2a504d0.jpg?v=1666187639"),
    Catogory(title: "Pants",image:"https://media.wired.com/photos/611c5312798f0e2c853b702f/1:1/w_993,h_993,c_limit/Gear-Cargo-Pants-are-Back-1302952122.jpg" ),
    Catogory(title: "shoes",image: "https://www.fashionbeans.com/wp-content/uploads/2022/10/thedenimdentist_BestBootBrands.jpg"),


  ];