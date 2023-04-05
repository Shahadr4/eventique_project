
import 'package:eventique/src/screen/home/widget/detials_screen.dart';
import 'package:eventique/src/screen/home/widget/product_card.dart';
import 'package:eventique/src/screen/home/widget/section_tile.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../provider/product_provider.dart';


class Men extends StatelessWidget {
   const Men({
    super.key, 
  });
  

  

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment. start,
      children: [
        SectionTile( 
          title:  "Men",
        
        ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal, 
               child: 
               Consumer<ProductProvider>(
        builder: (context, cart, child) =>
                
               
               Row( 
                children: List.generate(cart.menList.length, (index) =>Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProductCard(title: cart.menList[index].title, image: cart.menList [index].image, price:  cart.menList[index].price,press: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(productDetails:cart.menList[index],),));
                  }),
                )),
               ),
             ),
          )
      ],
    );
  }
} 
  