import 'package:eventique/src/const/size.dart';
import 'package:eventique/src/screen/home/Homepage/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../model/product.dart';
import '../details/detials_screen.dart';


class AllListProduct extends StatelessWidget {
  const AllListProduct({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
    body: SafeArea(
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        childAspectRatio: 0.6,            
        
               
               
                children: List.generate(list_Product.length, (index) =>Padding(
                  padding: const EdgeInsets.all(tDefaultSize) , 
                  child: ProductCard(title: list_Product[index].title, image:  list_Product[index].image, price:  list_Product[index].price,press: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(productDetails: list_Product[index]),));
                  }),
                )),
              
              
             ),
    ),
   );
  }
}