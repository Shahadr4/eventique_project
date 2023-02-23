import 'package:eventique/src/const/color.dart';
import 'package:eventique/src/const/fonts.dart';
import 'package:eventique/src/const/size.dart';
import 'package:eventique/src/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.productDetails});
  final Product productDetails;


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
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_border_outlined,
                color: Colors.black,
              ))
        ],
      ),
      body: Column(
         
        children: [
          Image.network(
           productDetails.image,
            height: MediaQuery.of(context).size.height * 0.4,
            fit: BoxFit.cover,
          ),
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(218, 215, 212, 212),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(tDefaultSize),
                  topRight: Radius.circular(tDefaultSize)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10,20,10,10), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, 
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,  
                 children: [
                  
                  
                  Row(
                    
                    children:  [ 
                      Expanded(child: Text(productDetails.title,style: tHeading1,)),
                     
                     
                    ],
                  ),
                  Text("fsafefawdetfwetewjt rgjerokjgeijg rgjre[iwhgehjrqwijhy5toihyj jijgrohjwtijhwtjh] ",style: tHeading2,), 
                  SizedBox(height: 10,), 
                  Text("SIZE :",style: tHeading3,),  
                

                  Row(
                    children: [
                      SizeDot(
                        size: "S",
                        isActive: true, 
                        press: () {
                          
                        },
                      ),
                         SizeDot(
                    size: "M",
                    isActive: false,
                    press: () {
                      
                    }, 
                  ),
                   SizeDot(
                    size: "L",
                    isActive: false,
                    press: () {
                      
                    },
                  ),
                   SizeDot(
                    size: "XL", 
                    isActive: false,
                    press: () {
                      
                    },
                  ),
                    ],
                  ),
                                   
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                    children: [
                       Text("\$ "+productDetails.price,style: tHeading1,), 
                         SizedBox(width: 10,),   
                      SizedBox(
                        width: 200,
                        height: 48, 
                        child: ElevatedButton(onPressed: (){},
                        style: ElevatedButton.styleFrom(primary: tButtonColor) ,
                        child: Text("Add  To Cart") ,
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
    
    super.key, required this.size, required this.isActive, required this.press,
  });
  final String size;
  final bool isActive;
  final VoidCallback press;

 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.all( 10/4),
        decoration: BoxDecoration(border: Border.all(color:isActive? Colors.red: Colors.transparent), 
        shape: BoxShape.circle,
    
        ),
        child: CircleAvatar(
          radius: 20, 
          backgroundColor: Colors.grey.shade400,
          child: Text(size,style:tSubHeading,),      
        ),
      
      ),
    );
  }
}
