import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventique/src/const/color.dart';
import 'package:eventique/src/const/fonts.dart';
import 'package:eventique/src/const/size.dart';
import 'package:eventique/src/model/product.dart';
import 'package:eventique/src/screen/home/widget/sizedot_widget.dart';

import 'package:eventique/src/services/cart_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'package:provider/provider.dart';


import '../../../provider/product_provider.dart';


class DetailScreen extends StatefulWidget {
  DetailScreen({Key? key, required this.productDetails, }) 
      : super(key: key);
  final Product productDetails;

  @override
  State<DetailScreen> createState() => _DetailScreenState();

  
}

   final user = FirebaseAuth.instance.currentUser!;
    CollectionReference likeCollection = FirebaseFirestore.instance
      .collection("users")
      .doc(user.uid)
      .collection("Favourite");

class _DetailScreenState extends State<DetailScreen> {

         


  CartServices cartServices = CartServices();


  String? _selectedSize;
  bool isSizeSelected = false;

  void _onSizeSelected() {
    setState(() {
      isSizeSelected = true;
    });
  }
  //used to adding likebutton to localstorage
   @override
  void initState() {
    super.initState();
   
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
        actions: [  
         IconButton(
           onPressed: () async {
             await Provider.of<ProductProvider>(context, listen: false).addToLike(widget.productDetails); 
            
           },
           icon:  StreamBuilder(
    stream: likeCollection
        .where('name', isEqualTo: widget.productDetails.title)
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Icon(Icons.favorite_border, color: Colors.grey);
      
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Icon(Icons.favorite_border, color: Colors.grey); 
          
      }
      if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
        return Icon(Icons.favorite, color: Colors.red);
        
      } else {
        return Icon(Icons.favorite_border, color: Colors.grey);
        
      }
    },
  ),
         ),
         
        ],
      ),
      body: Column(
        children: [
          Image.network(
            widget.productDetails.image,
            height: MediaQuery.of(context).size.height * 0.4,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(tDefaultSize),
                  topRight: Radius.circular(tDefaultSize),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.productDetails.title,
                            style: tHeading1,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "fsafefawdetfwetewjt rgjerokjgeijg rgjre[iwhgehjrqwijhy5toihyj jijgrohjwtijhwtjh] ",
                      style: tHeading2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "SIZE :",
                      style: tHeading3,
                    ),
                    Row(
                      children: [
                        SizeDot(
                          size: "S",
                          isActive: _selectedSize == "S",
                          press: () {
                            setState(() {
                              _selectedSize = "S";
                              _onSizeSelected();
                            });
                          },
                        ),
                        SizeDot(
                          size: "M",
                          isActive: _selectedSize == "M",
                          press: () {
                            setState(() {
                              _selectedSize = "M";
                              _onSizeSelected();
                            });
                          },
                        ),
                        SizeDot(
                          size: "L",
                          isActive: _selectedSize == "L",
                          press: () {
                            setState(() {
                              _selectedSize = "L";
                              _onSizeSelected();
                            }); 
                          },
                        ),
                        SizeDot(
                          size: "XL",
                          isActive: _selectedSize == "XL",
                          press: () {
                            setState(() {
                              _selectedSize = "XL";
                              _onSizeSelected();
                            });
                          }, 
                        ),
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\₹ ${widget.productDetails.price}",
                        style: tHeading1,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 200,
                        height: 48,
                        child: ElevatedButton(
              onPressed: isSizeSelected ? () {
                
 
               
                   Provider.of<ProductProvider>(context, listen: false).addProduct(widget.productDetails,_selectedSize);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                 
                    content: Text(
                        '${widget.productDetails.title} added to cart'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              } :() {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(behavior: SnackBarBehavior.floating,
                
          
                    content: Text(
                        "Please select your size"), 
                    duration: Duration(seconds: 1),
                  ),
                );
                
              }, // disable the button if no size is selected
              style: ElevatedButton.styleFrom(
                  backgroundColor: tButtonColor),
              child: const Text("Add  To Cart"),
            ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
  
 
}


