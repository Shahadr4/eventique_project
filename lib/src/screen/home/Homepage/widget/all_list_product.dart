import 'package:eventique/src/const/size.dart';

import 'package:eventique/src/screen/home/Homepage/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../../model/cart.dart';
import '../../../../model/product.dart';
import '../details/detials_screen.dart';


class AllListProduct extends StatelessWidget {
   AllListProduct({super.key});
   
  

  @override
  Widget build(BuildContext context) {
   return Scaffold(
    body: SafeArea(
      child:Consumer<Cart>(
        builder: (context, cart, child) =>
       GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        childAspectRatio: 0.6,            
        
               
               
                children: List.generate(cart.products.length, (index) =>Padding(
                  padding: const EdgeInsets.all(tDefaultSize) , 
                  child: ProductCard(title: cart.products[index].title, image:  cart.products[index].image, price:  cart.products[index].price,press: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(productDetails: cart.products[index] ,index: index, ),));
                  }),
                )),
       )
              
              
             ),
    ),
   );
  }
}