import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eventique/src/const/color.dart';

import 'package:flutter/material.dart';
 


ValueNotifier<int> indexChangeBtmNav= ValueNotifier(0);//cration of key used to the index of bottomnavigation bar 

//we also create valuelisenarable builder for getting index


class BtnNavBar extends StatefulWidget {
  const BtnNavBar({super.key});

  @override
  State<BtnNavBar> createState() => _BtnNavBarState();
}

class _BtnNavBarState extends State<BtnNavBar> {
  

  @override
  Widget build(BuildContext context) {
   
      return ValueListenableBuilder(valueListenable: indexChangeBtmNav, builder:(context,int newIndex, _) {
        return CurvedNavigationBar(
        
          
        backgroundColor: Color.fromARGB(0, 252, 241, 241),
        color:t2Color ,
           
        
        items: const [
              Icon(Icons.home, ),  
                
              Icon(Icons.favorite),
              Icon(Icons.shopping_cart),
              
              Icon(Icons.account_circle),
 
          ],
          index: newIndex,
          onTap: (index) {
            indexChangeBtmNav.value=index;
            
          
         }, 
          height: 57,
         
        animationDuration: const Duration(milliseconds: 300),
          

          
          
           );
      },
    );
    
  }


}
