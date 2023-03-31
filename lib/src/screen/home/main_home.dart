
import 'package:eventique/src/screen/home/Homepage/home_screen.dart';

import 'package:eventique/src/screen/home/cart/cart.dart';
import 'package:eventique/src/screen/home/navigationBar/curved_navigation.dart';
import 'package:eventique/src/screen/home/profile/profile.dart';
import 'package:eventique/src/screen/home/wishlist/favourite.dart';
import 'package:flutter/material.dart';


class HomeMain extends StatelessWidget {
  HomeMain({super.key});
   final _pages =[


     HomeScreen(),
    const Favourite(),
    CartPage(),
    const Profile()



  ];
 
  @override
  Widget build(BuildContext context) {

   
    return Scaffold(
      resizeToAvoidBottomInset: false,  
      extendBody: true,
      backgroundColor: Colors.transparent,
     
      body:  ValueListenableBuilder(valueListenable:indexChangeBtmNav , builder: (context,int index, child) {
      return _pages[index];
      
    },),
    bottomNavigationBar: const BtnNavBar() ,
 

     
    );
  }
} 