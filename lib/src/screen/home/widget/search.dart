import 'package:eventique/src/screen/home/widget/customText.dart';

import 'package:eventique/src/screen/home/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../const/color.dart';
 
import '../../../provider/product_provider.dart';
import 'detials_screen.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
     final productprovider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,  
        elevation: 0, 
        title:   ListTile(
          leading: const Icon(
            Icons.search,
            color: Colors.black,
          ),
          title: TextField(
            textInputAction: TextInputAction.search,
            onSubmitted: (pattern)async{
              await productprovider.search(productName: pattern);
        
            },
            decoration: const InputDecoration(
              hintText: "search...", 
              border: InputBorder.none,
            ),
          ),
        ),


      ),
      body:  productprovider.productsSearched.length < 1? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.search, color: Colors.grey, size: 30,),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomText(text: "No products Found", color: Colors.grey, weight: FontWeight.w300, size: 22,),
            ],
          )
        ],
      ) : ListView.builder(
          itemCount: productprovider.productsSearched.length,
          itemBuilder: (context, index){
            return GestureDetector(
                onTap: ()async{
               
                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(productDetails: productprovider.productsSearched[index], ),));

                },
                
               child:Padding(
                 padding: const EdgeInsets.all(8.0),
                child:  Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 215, 213, 213),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.white)),
                          child: ListTile(
                            leading: Image.network( productprovider.productsSearched[index].image),
                            title: Text( productprovider.productsSearched[index].title),
                             
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               
                                Text("\$${ productprovider.productsSearched[index].price}"),
                              ],
                            ),))
       
               ), 
               );
          }),
    );
  }
}
