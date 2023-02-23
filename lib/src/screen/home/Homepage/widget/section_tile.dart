
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../const/fonts.dart';

class SectionTile extends StatelessWidget {
  const SectionTile({
   required this.title,
   required this.pressSeeAll,
    super.key,
  });
  final String title;
  final VoidCallback pressSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title ,style: tHeading2,),
        TextButton(onPressed:pressSeeAll, child: const Text("See All"))
      ],
    );
  }
}