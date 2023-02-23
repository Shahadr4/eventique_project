import 'package:eventique/src/screen/home/Homepage/details/detials_screen.dart';
import 'package:eventique/src/screen/home/Homepage/widget/product_card.dart';
import 'package:eventique/src/screen/home/Homepage/widget/section_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../model/product.dart';
import 'all_list_product.dart';

class Popular extends StatelessWidget {
  const Popular({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
               child: Row( 
                children: List.generate(list_Product.length, (index) =>Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProductCard(title: list_Product[index].title, image:  list_Product[index].image, price:  list_Product[index].price,press: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(productDetails: list_Product[index]),));
                  }),
                )),
               ),
             ) 
      ],
    );
  }
}
 