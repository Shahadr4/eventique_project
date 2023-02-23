
import 'package:eventique/src/screen/home/Homepage/widget/new_arrival.dart';
import 'package:eventique/src/screen/home/Homepage/widget/popular.dart';

import 'package:eventique/src/screen/home/Homepage/widget/searchbar_catogary.dart';

import 'package:flutter/material.dart';
import 'package:eventique/src/model/catogorymodel.dart';

import 'widget/catogorylist.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) { 

    const outlineInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        borderSide: BorderSide.none);
    return Scaffold(
      extendBody: true,
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/app_logo.png"),
                const SearchbarAndcatogary(
                    outlineInputBorder: outlineInputBorder),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      list_catogory.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CatogoryCard(
                          title: list_catogory[index].title,
                          image: list_catogory[index].image,
                          press: () {},
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const NewArrival(),
                const SizedBox(height: 10,),

                const Popular()
                
             
              ],
            ),
          ),
        ),
      ),
    );
  }
}

