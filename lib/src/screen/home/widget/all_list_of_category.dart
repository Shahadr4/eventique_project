import 'package:eventique/src/screen/home/widget/detials_screen.dart';
import 'package:eventique/src/screen/home/widget/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../const/size.dart';
import '../../../provider/product_provider.dart';

class AllListCategory extends StatelessWidget {



    AllListCategory({super.key,
   required this.name
   }); 
     String name;
  

  @override
  Widget build(BuildContext context) {
    
    
   return Scaffold(
     appBar:  AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width*0.20,),       
            Text(name,  
              style: GoogleFonts.eczar(
            color: const Color.fromARGB(255, 255, 255, 255),
            fontSize: 40,
              ),
            ),
          ],
        ),
      ),

    body: SafeArea(
      child:Consumer<ProductProvider>(
        builder: (context, product, child) =>
       GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        childAspectRatio: 0.6,            
         
               
               
                children: List.generate(product.productsCategory.length, (index) =>Padding(
                  padding: const EdgeInsets.all(tDefaultSize) , 
                  child: ProductCard(title: product.productsCategory[index].title, image:  product.productsCategory[index].image, price:  product.productsCategory[index].price,press: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(productDetails: product.productsCategory[index] , ),)); 
                  }),
                )),
       )
              
              
             ),
    ),
   ); 
  }
}