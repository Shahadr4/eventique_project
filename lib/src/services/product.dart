import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventique/src/model/product.dart';

import '../model/catogorymodel.dart';

class ProductServices {
  FirebaseFirestore firstore = FirebaseFirestore.instance;

  Future<List<Product>> getPoduct() async {
    return firstore.collection("products").get().then((value) {
      List<Product> products1 = [];
      for (DocumentSnapshot product in value.docs) {
        products1.add(Product.fromFirestore(product));
      }
      return products1;
    });
  }

  Future<List<CatogoryName>> getCategories() async {
    return firstore.collection('categories').get().then((value) {
      List<CatogoryName> catogories = [];
      for (DocumentSnapshot category in value.docs) {
        catogories.add(CatogoryName.fromFirestore(category));
      }
      return catogories;
    });
  }

  Future<List<Product>> searchProducts({required String productName}) {
    // code to convert the first character to uppercase

    String searchKey = productName[0].toUpperCase() + productName.substring(1);
    return firstore
        .collection('products')
        .orderBy("title")
        .startAt([searchKey])
        .endAt(['$searchKey\uf8ff'])
        .get()
        .then((result) {
          List<Product> products = [];
          for (DocumentSnapshot product in result.docs) {
            products.add(Product.fromFirestore(product));
          }
          return products;
        });
  }

  //getting product of Category list

    Future<List<Product>> getProductsOfCategory({required String categories}) async =>
      FirebaseFirestore.instance
          .collection("products")
          .where("categories", isEqualTo: categories)
          .get()
          .then((result) {
        List<Product> products = [];
        for (DocumentSnapshot product in result.docs) {
          products.add(Product.fromFirestore(product));
        }
        return products;
      });



   Future<List<Product>> getPopularList() async =>
      FirebaseFirestore.instance
          .collection("products")
          .where("popular", isEqualTo: true)
          .get()
          .then((result) {
        List<Product> products = [];
        for (DocumentSnapshot product in result.docs) {
          products.add(Product.fromFirestore(product));
        }
        return products;
      });



    










}
