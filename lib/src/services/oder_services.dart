import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventique/src/model/cartModel.dart';
import 'package:eventique/src/model/oders_model.dart';

class OderServices{
  FirebaseFirestore firstore = FirebaseFirestore.instance;
  Future<void>addOders(List<CartedModel> cart,String amount,String userName,String uid,int num,String houseName,String pin,String city,String state,String phone )async{
    try{
      List<Map<String, dynamic>> cartData =  
    cart.map((cartModel) => cartModel.toJson()).toList();



     Map<String, dynamic> oderDetails = {
      'price':amount,
      'name':userName, 
      'carted':cartData,  
      'houseName':houseName,
      'pin':pin,
      'city':city,
      'state':state,
      'phone':phone,


    
      'uid': uid,  
      'number' :num,
      
      'create at':Timestamp.now()

    };
    await FirebaseFirestore.instance.collection("oders").add(oderDetails);
      



    }catch(e){

    }



  }




Future<List<OderModel>> getOrders(String uid ) async {   
  final FirebaseFirestore firestore = FirebaseFirestore.instance; 
  QuerySnapshot<Map<String, dynamic>> snapshot =
      await firestore.collection("oders")
.where("uid",isEqualTo: uid ).get(); 

  List<OderModel> orders = snapshot.docs
      .map((doc) => OderModel.fromFirestore(doc))
      .toList();

  return orders; 
} 



}