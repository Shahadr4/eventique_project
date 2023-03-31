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

class NewArrival extends StatelessWidget {

  const NewArrival({
    super.key,
   
  });

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Column(
       crossAxisAlignment: CrossAxisAlignment. start,
      children: [
        const SectionTile(
          title: "New Arrival",
        ),
        SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: List.generate(
                  productProvider.products1.length,
                    (index) {
                      
                      return Padding(
                        padding: EdgeInsets.all(8),
                        child: ProductCard(
                         image: productProvider.products1[index].image,
                          price:  productProvider.products1[index].price.toDouble(),

                          title: productProvider.products1[index].title,
                          press: () {
                           
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(productDetails:productProvider.products1[index] , ),));
                          },
                        ),
                      );
                    },
                  ), 
                ),
              )
      
      ],
    );
  }
}

