import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventique/src/provider/product_provider.dart';

 
import 'package:eventique/src/screen/home/widget/detials_screen.dart';
import 'package:eventique/src/screen/home/widget/product_card.dart';
import 'package:eventique/src/screen/home/widget/section_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../model/product.dart';
import 'all_list_product.dart';

class WomenList extends StatelessWidget {

  const WomenList({
    super.key,
   
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment. start,
      children: [
        SectionTile( 
          title:  "Women",
        
        ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal, 
               child: 
               Consumer<ProductProvider>(
        builder: (context, cart, child) => 
                
               
               Row( 
                children: List.generate(cart.womenList.length, (index) =>Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProductCard(title: cart.womenList[index].title, image: cart.womenList [index].image, price:  cart.womenList[index].price,press: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(productDetails:cart.womenList[index],),));
                  }),
                )),
               ),
             ),
          )
      ],
    );
  }
}

