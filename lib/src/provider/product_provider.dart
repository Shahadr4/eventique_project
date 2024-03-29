

// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventique/src/model/cartModel.dart';
import 'package:eventique/src/model/catogorymodel.dart';
import 'package:eventique/src/model/oders_model.dart';
import 'package:eventique/src/model/product.dart';

import 'package:eventique/src/services/carted_services.dart';
import 'package:eventique/src/services/oder_services.dart';
import 'package:eventique/src/services/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ProductProvider extends ChangeNotifier {






 

  Future<void> addProduct(Product prd, String? size,String? uid) async {
    late CollectionReference cartCollection = FirebaseFirestore.instance.collection('users').doc(uid).collection('cart');

    prd.size = size;

    await cartCollection.add({
      'name': prd.title,
      'price': prd.price,
      'size': prd.size,
      'image': prd.image,
      'liked':prd.isFavorite, 
    }); 
    loadcarted(); 

  } 

  Future<void> addToLike(Product product,String uid)async{
    late CollectionReference likeCollection = FirebaseFirestore.instance.collection('users').doc(uid).collection("Favourite");
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
      
      
    });  
  
  }

  }


  
 
     

 
  Future<void> removeProduct(String cartId,String uid,int index) async  {
    late CollectionReference cartCollection = FirebaseFirestore.instance.collection('users').doc(uid).collection('cart');
     if (cartCollection == null) return;
   
    await cartCollection.doc(cartId).delete();
    carted.removeAt(index);
   
    
    notifyListeners(); 
  } 

  final ProductServices _productServices=ProductServices();
  List<Product> products1=[];
  List<Product>liked=[]; 
  List<CatogoryName>catogories1=[];
  List<Product> productsSearched = [];
  List<Product>productsCategory=[];
  List<Product>menList=[];
  List<Product>womenList=[];
   final CartedServices cartedServices= CartedServices();
  
 
  List<CartedModel>carted =[]; 

  List<OderModel>orders=[];
  final OderServices oderServices = OderServices(); 

 
  ProductProvider.initialize(){
    loadProducts();
    loadcarted();
    loadOrders ();
  
   

  }
   loadProducts()async{
    products1 = await _productServices.getPoduct();
    catogories1= await _productServices.getCategories();
     menList = await _productServices.getMenList();
    womenList = await _productServices.getwomenList();
   
      


 
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
  
loadcarted()async{
 carted = await cartedServices.getCategories(FirebaseAuth.instance.currentUser!.uid);    
 
  notifyListeners();  

} 
loadOrders() async {
  // Check if the user is authenticated
  if (FirebaseAuth.instance.currentUser == null) {
    print('User is not authenticated');
    return;
  }

  // User is authenticated, load orders
  orders = await oderServices.getOrders(FirebaseAuth.instance.currentUser!.uid); 
     
  notifyListeners();
}

 addOders(List<CartedModel>cart, String amount, String userName,String uid, int num,houseName, String pin, String city,String state, String phone) async {
    await oderServices.addOders(cart, amount, userName, uid, num, houseName, pin, city, state, phone);
    loadOrders();  
    notifyListeners(); 
  }

 


 

  

  




}

