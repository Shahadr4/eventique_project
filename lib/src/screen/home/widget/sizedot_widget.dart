

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../const/fonts.dart';

class SizeDot extends StatelessWidget {
  const SizeDot({
    super.key,
    required this.size,
    required this.isActive,
    required this.press,
  });
  final String size;
  final bool isActive;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.all(10 / 4),
        decoration: BoxDecoration(
          border: Border.all(color: isActive ? Colors.red : Colors.transparent),
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          radius: 20,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          child: Text(
            size,
            style: tSubHeading,
          ),
        ),
      ),
    );
  }
}

