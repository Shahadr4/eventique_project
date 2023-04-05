
import 'package:eventique/src/const/fonts.dart';
import 'package:eventique/src/provider/product_provider.dart';
import 'package:eventique/src/provider/user_providers.dart';
import 'package:eventique/src/screen/home/widget/odered_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class OrdersList extends StatefulWidget {
   OrdersList({super.key,  this.index});
  int? index;

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     
    
        
    

  }
  
  @override            
  Widget build(BuildContext context) {
    final ProductProvider productProvider = Provider.of<ProductProvider>(context);    
       
   


    return  Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
            child: Text(
          'MY ORDERS',
          style: GoogleFonts.eczar(
            color: const Color.fromARGB(255, 255, 255, 255),
            fontSize: 40,
          ),
        )),
      ),

      body:ListView.builder(
          itemCount: productProvider.orders.length ,
          itemBuilder: (context, index) {
            
        DateTime createdAt = productProvider.orders[index].createdAt.toDate();
        String formattedDate =
            DateFormat('yyyy-MM-dd  ').format(createdAt);
        

            return Padding(
              padding: const EdgeInsets.all(13),
              child: Container(
                
                height: MediaQuery.of(context).size.height*0.3,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),  
                   borderRadius: BorderRadius.circular(8), 
                   border: Border.all(
                    color: Color.fromARGB(255, 248, 248, 247)
                   )

                ),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                             
                               height:236, 
                              width: 145  ,
                              child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal, 
                                        child: Row(
                                          children: List.generate(productProvider.orders[index].number, (index1) => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: OderedCart(title: productProvider.orders[index].carted[index1]['name'], image: productProvider.orders[index].carted[index1]['image'], price: productProvider.orders[index].carted[index1]['price'],size:productProvider.orders[index].carted[index1]['size']  ),
                                          ))
                                        ),
                                        
                            ),
                            ),

                          
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start ,
                              children: [
                                Text("odered Date  :",style: tHeading3 ,),
                                SizedBox(height: 20,), 
                                Text(  formattedDate),
                                    SizedBox(height: 20,), 
                                    Text("Total Price :",style: tHeading3,),
                                        SizedBox(height: 20,), 
                                        Text('${productProvider.orders[index].price}',style: tHeading2,)
                                
                              ],
                            ),
                           
                            
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                
              ),
            );

          },



      )
    );
  }
}