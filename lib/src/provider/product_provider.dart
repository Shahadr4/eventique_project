

// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventique/src/model/catogorymodel.dart';
import 'package:eventique/src/model/product.dart';
import 'package:eventique/src/services/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ProductProvider extends ChangeNotifier {

 //carting and liked button


final  users =FirebaseAuth.instance.currentUser;
late CollectionReference cartCollection = FirebaseFirestore.instance.collection('users').doc(users!.uid).collection('cart');
late CollectionReference likeCollection = FirebaseFirestore.instance.collection('users').doc(users!.uid).collection("Favourite");


 

  Future<void> addProduct(Product prd, String? size) async {
    prd.size = size;

    await cartCollection.add({
      'name': prd.title,
      'price': prd.price,
      'size': prd.size,
      'image': prd.image,
      'liked':prd.isFavorite, 
    }); 
  } 

  Future<void> addToLike(Product product)async{
     if (likeCollection == null) return; 
   

  
  final likeDoc = await likeCollection.where('name', isEqualTo: product.title).get();
  if (likeDoc.docs.isNotEmpty) {
    // The item is already marked as a favorite, remove it
    final docId = likeDoc.docs.first.id;
    await likeCollection.doc(docId).delete();
    
  } else {
    // The item is not marked as a favorite, add it
    await likeCollection.add({
      'name': product.title,
      'price': product.price,
      'size': product.size, 
      'image': product.image,
      'popular':product.popular 
      
    });  
  }

  }


  
 
     

 
  Future<void> removeProduct(String cartId) async  {
     if (cartCollection == null) return;
   
    await cartCollection.doc(cartId).delete();
    notifyListeners(); 
  } 

  final ProductServices _productServices=ProductServices();
  List<Product> products1=[];
  List<Product>liked=[]; 
  List<CatogoryName>catogories1=[];
  List<Product> productsSearched = [];
  List<Product>productsCategory=[];
  List<Product>popularProduct=[];
  
 
  List<Product>carted =[];
 
  ProductProvider.initialize(){
    loadProducts();
   

  }
   loadProducts()async{
    products1 = await _productServices.getPoduct();
    catogories1= await _productServices.getCategories();
     popularProduct = await _productServices.getPopularList();


 
    notifyListeners();
  }

  Future loadProductByCategory(String categoryname)async{

    productsCategory=await _productServices.getProductsOfCategory(categories: categoryname);
    notifyListeners();
  }
  Future search({required String productName})async{
    productsSearched= await _productServices.searchProducts(productName: productName); 
    notifyListeners();
  }
 


 

  

  




}

