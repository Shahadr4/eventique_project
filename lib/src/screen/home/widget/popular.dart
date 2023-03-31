
import 'package:eventique/src/screen/home/widget/detials_screen.dart';
import 'package:eventique/src/screen/home/widget/product_card.dart';
import 'package:eventique/src/screen/home/widget/section_tile.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../provider/product_provider.dart';


class Popular extends StatelessWidget {
   const Popular({
    super.key,
  });
  

  

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment. start,
      children: [
        SectionTile( 
          title:  "Popular",
        
        ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal, 
               child: 
               Consumer<ProductProvider>(
        builder: (context, cart, child) =>
                
               
               Row( 
                children: List.generate(cart.popularProduct.length, (index) =>Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProductCard(title: cart.popularProduct[index].title, image: cart.popularProduct [index].image, price:  cart.popularProduct[index].price,press: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(productDetails:cart.popularProduct[index],),));
                  }),
                )),
               ),
             ),
          )
      ],
    );
  }
} 
  