
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../const/fonts.dart';

class SectionTile extends StatelessWidget {
  const SectionTile({
   required this.title,
   
    super.key,
  });
  final String title;
 

  @override
  Widget build(BuildContext context) {
    return Text(title ,style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 26,
      color: Colors.white  
    ),);
  }
}