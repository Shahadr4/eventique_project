

import 'package:flutter/material.dart';

import '../../../const/fonts.dart';

// ignore: must_be_immutable
class ProductCard extends StatelessWidget {
   ProductCard({
    required this.title,
    required this.image,
    required this.price,
    required this.press,
    super.key,
  });
  final String title,image;
  final VoidCallback press;
   double price; 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:press,
      child: Container(
        width: 145, 
        height: 230,   
        padding: const EdgeInsets.all(1),
      
        decoration:  BoxDecoration(
            color:Colors.grey[300],
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 145,
              height: 145,
            
              child: Container(
                width: double.infinity,
                decoration:  BoxDecoration(
                  image:   DecorationImage(image: NetworkImage(image),fit: BoxFit.cover ), 
                
                    color: Color.fromARGB(255, 255, 254, 254),
                    borderRadius:
                        BorderRadius.all(Radius.circular(10))),


              
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(  
                  
                crossAxisAlignment: CrossAxisAlignment.center,  
                
                   
                children: [ 
                  Padding( 
                    padding: const EdgeInsets.all(5), 
                    child: Text(
                      title,
                      style: tSubHeading,
                    ),
                  ),
                
                  Center(
                    child: Text(
                      "\₹ $price",
                      style: tHeading2,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
