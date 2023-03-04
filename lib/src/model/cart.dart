import 'dart:convert';

import 'package:eventique/src/model/product.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends ChangeNotifier {
  final List<Product> _products = [
    Product(
        title: "Grey Full Sleeves Shirts",
        image:
            "https://imagescdn.allensolly.com/img/app/product/8/863740-10207643.jpg?q=75&auto=format&w=342",
        price: 1999.0),
    Product(
        title: "Full Sleeves Casual Shirts",
        image:
            "https://imagescdn.allensolly.com/img/app/product/8/863739-10207621.jpg?q=75&auto=format&w=342",
        price: 1699),
    Product(
        title: "Men White Solid Crew Neck T-Shirt",
        image:
            "https://imagescdn.allensolly.com/img/app/product/7/712223-7801991.jpg?q=75&auto=format&w=342",
        price: 648),
    Product(
        title: "Men Grey Slim Fit Solid Casual Trousers",
        image:
            "https://imagescdn.allensolly.com/img/app/product/8/859809-10145082.jpg?q=75&auto=format&w=342",
        price: 2499),
    Product(
        title: "Men Brown Lace-Up Lace Up Shoes",
        image:
            "https://imagescdn.allensolly.com/img/app/product/8/806265-9567092.jpg?q=75&auto=format&w=342",
        price: 1779)
  ];
  final List<Product> _cart = [];

  List<Product> get products => _products;
  List<Product> get cartItmes => _cart;

  Future<void> addProduct(int index) async {
    _cart.add(_products[index]);

    final studentDb = await Hive.openBox<Product>('product_db');
    await studentDb.add(_products[index]);
    notifyListeners();
  }

  Future<void> removeProduct(int index) async {
    _cart.removeAt(index);
    final studentDb = await Hive.openBox<Product>('product_db');
    await studentDb.deleteAt(index);

    notifyListeners();
  }

  Future<void> getCartlist() async {
    final studentDb = await Hive.openBox<Product>('product_db');
    _cart.clear();
    _cart.addAll(studentDb.values);
    notifyListeners();
  }
}
