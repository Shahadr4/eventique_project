import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchbarAndcatogary extends StatelessWidget {
  const SearchbarAndcatogary({
    super.key,
    required this.outlineInputBorder,
  });

  final OutlineInputBorder outlineInputBorder;

  @override
  Widget build(BuildContext context) {
    return Form(child: TextFormField(
      
      decoration: InputDecoration(
        filled: true,
        hintText: "Search items...",
        fillColor: Color.fromARGB(189, 255, 255, 255),
        prefixIcon: const Icon(Icons.search_rounded,color: Colors.grey,),
        suffixIcon: SizedBox(
          height: 48,
          width: 48, 
          child: ElevatedButton(onPressed: (){}, child:Icon(Icons.format_list_numbered_rtl_rounded))),
      border: outlineInputBorder,
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,

       
      ), 
    ));
  }
}