
import 'package:flutter/cupertino.dart';

import '../../../../const/fonts.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.title,
    required this.image,
    required this.price,
    required this.press,
    super.key,
  });
  final String title,image,price;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:press,
      child: Container(
        width: 145, 
        height: 230,   
        padding: const EdgeInsets.all(1),
      
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 218, 217, 217),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 145,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 234, 233, 233),
                    borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                child: Image.network(
                 image,
                  height: 132,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                  Text(
                    "\$ $price",
                    style: tHeading2,
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
