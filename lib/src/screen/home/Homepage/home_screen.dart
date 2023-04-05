
import 'package:eventique/src/const/color.dart';

import 'package:eventique/src/screen/home/widget/list_catogary.dart';


import 'package:eventique/src/screen/home/widget/womwnList.dart';
import 'package:eventique/src/screen/home/widget/menList.dart';
import 'package:eventique/src/screen/home/widget/search.dart';


import 'package:flutter/material.dart';  

import 'package:provider/provider.dart';

import '../../../provider/product_provider.dart';


class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

 


  @override
  Widget build(BuildContext context) {
    final Productprovider = Provider.of<ProductProvider>(context);
    
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: t2Color,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Image.asset(
              "assets/app_logo.png",
              height: 60,
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(),));  
              

              },
              icon: const Icon(
                Icons.search_sharp,
                color: Colors.black,
              ))
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                

                catogory(Productprovider: Productprovider),
                const SizedBox( 
                  height: 10,
                ),
               
                WomenList(),
                const SizedBox(
                  height: 10,
                ),
                const Men(),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  } 
}
