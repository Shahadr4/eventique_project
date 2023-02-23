
import 'package:flutter/material.dart';


class SquareBox extends StatelessWidget {
 
  final String imagepath;
  const SquareBox({super.key,required this.imagepath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      
      child: SizedBox(
        
        
        height: 50,
        child:Image.asset(imagepath),
      ),
    );
  }
}