import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../const/fonts.dart';

class CatogoryCard extends StatelessWidget {
  const CatogoryCard({

    super.key,
    required this.title,
    required this.press,
    required this.image,
  });
final String title;
final String image;
final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press, 
      child: CircleAvatar(  
        maxRadius: 40 ,     
          
        backgroundImage: NetworkImage(image),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: TextStyle(
      fontWeight: FontWeight.bold,
      fontStyle:FontStyle.italic ,
      fontSize: 17,
      color:  Color.fromARGB(255, 243, 245, 246),   
    ), ),
          ],
        ),
      ),
    );
  }
}