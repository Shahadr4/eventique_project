import 'package:eventique/src/const/color.dart';
import 'package:eventique/src/const/fonts.dart';
import 'package:eventique/src/const/size.dart';
import 'package:eventique/src/model/product.dart';
import 'package:eventique/src/screen/home/cart/cart.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../model/cart.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({super.key, required this.productDetails, required this.index});
  final Product productDetails;
  int index;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String? _selectedSize;
  bool isSizeSelected = false;

  void _onSizeSelected() {
    setState(() {
      isSizeSelected = true;
    });
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
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(),
                    ));
              },
              icon: const Icon(
                Icons.favorite_border_outlined,
                color: Colors.black,
              ))
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
            decoration:  BoxDecoration(
              color:Colors.grey[300],
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(tDefaultSize),
                  topRight: Radius.circular(tDefaultSize)),
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
                      )),
                    ],
                  ),
                  Text(
                    "fsafefawdetfwetewjt rgjerokjgeijg rgjre[iwhgehjrqwijhy5toihyj jijgrohjwtijhwtjh] ",
                    style: tHeading2,
                  ),
                  SizedBox(
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
                        "\$ " + widget.productDetails.price.toString(),
                        style: tHeading1,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 200,
                        height: 48,
                        child: ElevatedButton(
              onPressed: isSizeSelected ? () {
                Provider.of<Cart>(context, listen: false)
                    .addProduct(widget.index);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                 
                    content: Text(
                        '${widget.productDetails.title} added to cart'),
                    duration: Duration(seconds: 1),
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
              child: Text("Add  To Cart"),
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
        padding: EdgeInsets.all(10 / 4),
        decoration: BoxDecoration(
          border: Border.all(color: isActive ? Colors.red : Colors.transparent),
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          child: Text(
            size,
            style: tSubHeading,
          ),
        ),
      ),
    );
  }
}
