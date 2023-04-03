import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventique/src/model/userModel.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UsersProvider extends ChangeNotifier {
UsersProvider.initialize(){

    getUser();
    
   

  }
 
  FirebaseFirestore firstore = FirebaseFirestore.instance;

  UserModel? currentUser;

  UserModel? get  currentUserData{
    return currentUser; 
  }
  
   


  void getUser() async {
  
    UserModel userModel;

    var value = await firstore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    if (value.exists) {
      userModel = UserModel(
          image:value.get("imageUrl") , 
          name: value.get("name"),
          email: value.get('email'),
          phone: value.get("phone"));
          

          currentUser = userModel;
          notifyListeners();
    }
  }

}
