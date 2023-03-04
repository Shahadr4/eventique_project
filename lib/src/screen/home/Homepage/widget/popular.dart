
import 'package:eventique/src/model/cart.dart';
import 'package:eventique/src/screen/home/Homepage/details/detials_screen.dart';
import 'package:eventique/src/screen/home/Homepage/widget/product_card.dart';
import 'package:eventique/src/screen/home/Homepage/widget/section_tile.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../../model/product.dart';
import 'all_list_product.dart';

class Popular extends StatelessWidget {
   const Popular({
    super.key,
  });
  

  

  @override
  Widget build(BuildContext context) {
     final cart = Provider.of<Cart>(context);

    return Column(
      children: [
        SectionTile( 
          title:  "Popular",
          pressSeeAll: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AllListProduct()));
          }, 
        ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal, 
               child: 
               Consumer<Cart>(
        builder: (context, cart, child) =>
               
               
               Row( 
                children: List.generate(cart.products.length, (index) =>Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProductCard(title: cart.products[index].title, image: cart.products [index].image, price:  cart.products[index].price,press: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(productDetails:cart.products[index],index: index,),));
                  }),
                )),
               ),
             ),
          )
      ],
    );
  }
}
 