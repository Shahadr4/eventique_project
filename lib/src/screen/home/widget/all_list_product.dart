import 'package:eventique/src/const/size.dart';

import 'package:eventique/src/screen/home/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../provider/product_provider.dart';

import 'detials_screen.dart';


class AllListProduct extends StatelessWidget {
   const AllListProduct({super.key});

  @override
  Widget build(BuildContext context) {
    
   return Scaffold(
    body: SafeArea(
      child:Consumer<ProductProvider>(
        builder: (context, cart, child) =>
       GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        childAspectRatio: 0.6,            
         
               
               
                children: List.generate(cart.products1.length, (index) =>Padding(
                  padding: const EdgeInsets.all(tDefaultSize) , 
                  child: ProductCard(title: cart.products1[index].title, image:  cart.products1[index].image, price:  cart.products1[index].price,press: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(productDetails: cart.products1[index] , ),));
                  }),
                )),
       )
              
              
             ),
    ),
   );
  }
}