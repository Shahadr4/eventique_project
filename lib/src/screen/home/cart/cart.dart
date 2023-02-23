import 'package:flutter/material.dart';



class CartPage extends StatelessWidget {

  const CartPage({super.key});


  

  @override
  Widget build(BuildContext context) {
      void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        duration: const Duration(milliseconds: 400),
        content: Text(
          message,
          style: const TextStyle(color: Color.fromARGB(255, 233, 232, 232)),
        )));}


    
    
    return Scaffold(
      

      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 154, 156, 161),
        title:Center(child: Text("MY CART")),),
     
    );
  }
}