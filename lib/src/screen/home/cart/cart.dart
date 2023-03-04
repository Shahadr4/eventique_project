
import 'package:eventique/src/model/cart.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


import '../../../model/product.dart';

class CartPage extends StatefulWidget {
 

   const CartPage({super.key,});

  @override
  State<CartPage> createState() => _CartPageState();
}



class _CartPageState extends State<CartPage> {
   
  

  @override
  Widget build(BuildContext context) {
     final cart = Provider.of<Cart>(context);
    
    return Scaffold(
       
      appBar: AppBar(
         backgroundColor: Colors.transparent,
        elevation: 0, 
        title:  Center(child: Text('Shopping Cart',style: GoogleFonts.eczar(
          color: Color.fromARGB(255, 255, 255, 255),
          fontSize: 40,
        ),)), 
      ),
      body: Consumer<Cart>(builder: (context, value, child) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: value.cartItmes.length,
                itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(12.0), 
                child: Container(
                  decoration:  BoxDecoration(
                    color: Color.fromARGB(255, 215, 213, 213),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white) 
                    ), 
                  
                  child: ListTile(
                    leading: Image.network(value.cartItmes[index].image,),   
                    title: Text(value.cartItmes[index].title),
                    subtitle: Text("\$${value.cartItmes[index].price}"),  
                    trailing: IconButton
                    (icon: Icon(
                      Icons.cancel_rounded,color: Colors.red,),
                      onPressed: () => Provider.of<Cart>(context,listen: false).removeProduct(index),
                    
                      
                      ),

                
                  ),
                ),
              );
            },))
          ],

        );
      },), 
   
    );
  }
}