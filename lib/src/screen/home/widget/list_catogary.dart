import 'package:eventique/src/screen/home/widget/all_list_of_category.dart';
import 'package:eventique/src/screen/home/widget/all_list_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../provider/product_provider.dart';
import 'catogorylist.dart';


class catogory extends StatelessWidget {
  const catogory({
    super.key,
    required this.Productprovider,
  });

  final ProductProvider Productprovider;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
               Productprovider.catogories1.length,
                (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CatogoryCard(
                    title:Productprovider.catogories1[index].title ,
                    image: Productprovider.catogories1[index].image,
                    press: (() async{
                      Productprovider.loadProductByCategory(Productprovider.catogories1[index].title);

                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllListCategory(name: Productprovider.catogories1[index].title),));
                      
                    }),
                   
                  ),
                ),
              ),
            ),
          );
  }
}
