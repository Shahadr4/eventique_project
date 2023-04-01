

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../provider/product_provider.dart';


class CartPage extends StatefulWidget {
 CartPage({
    
    Key? key,
    

    }):super(key: key){
      _reference =FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);
      _collectionReference =_reference.collection("cart");
      
        
      

      


    } 
    
  @override
  State<CartPage> createState() => _CartPageState();
}
late DocumentReference _reference;
late CollectionReference _collectionReference;


class _CartPageState extends State<CartPage> {
  late Razorpay _razorpay;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    initializeRazorpay();
  }

  void initializeRazorpay() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlepaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlepaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void launchRazorpay(
    String amount,
    
  ) {
    double amnt = double.parse(amount) * 100;
    var options = {
      'key': "rzp_test_h0z4xuMxf2yEK3",
      'amount': amnt,
      'phone':"ffwfwef",
      "description": "nothing"
    };
    try {
      _razorpay.open(options);
    } catch (e) {
 ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(e.toString()),
        duration: const Duration(seconds: 1),
      ),
    );
      
      
    }
  }

  void _handlepaymentSuccess(PaymentSuccessResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text("payment success${response.orderId}\n ${response.paymentId}\n${response.signature}"),
        duration: Duration(seconds: 1),
      ),
    );

    clearCollection();  
  }

  void _handlepaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text("payment Failed" , style: TextStyle(color: Colors.red)),
        duration: Duration(seconds: 1), 
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text("payment Failed", style: TextStyle(color: Colors.red),),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
            child: Text(
          'Shopping Cart',
          style: GoogleFonts.eczar(
            color: const Color.fromARGB(255, 255, 255, 255),
            fontSize: 40,
          ),
        )),
      ),
      body: StreamBuilder(
        stream: _collectionReference.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData && streamSnapshot.data!.docs.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 215, 213, 213),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.white)),
                          child: ListTile(
                            leading: Image.network(documentSnapshot["image"]),
                            title: Text(documentSnapshot["name"]),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Size : ${documentSnapshot["size"]}",
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text("\₹ ${documentSnapshot["price"]}"),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.cancel_rounded,
                                color: Colors.red,
                              ),
                              onPressed: () =>
                                  Provider.of<ProductProvider>(context, listen: false)
                                      .removeProduct(documentSnapshot.id,_reference.id )
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                //toatal +pay now

                //if the cart item is 0 then total pay is hide
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 65),
                    child: FutureBuilder<double>(
                      future: calculateTotalPrice(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color:
                                    const Color.fromARGB(255, 139, 143, 148)),
                            padding: const EdgeInsets.all(25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      "Total Price : ",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      snapshot.data.toString(),
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                //paynow
                                GestureDetector(
                                  onTap: () =>
                                      launchRazorpay(snapshot.data.toString()),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                        borderRadius: BorderRadius.circular(8)),
                                    padding: const EdgeInsets.all(12),
                                    child: Row(
                                      children: const [
                                        Text(
                                          "Pay Now",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 16,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ))
              ],
            );
          } else {
            return Center(child: Lottie.asset('assets/112087-empty.json'));
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }


  
Future<double> calculateTotalPrice() async {
  double totalPrice = 0;
  QuerySnapshot querySnapshot = await _collectionReference.get();
  for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
    totalPrice += documentSnapshot['price'];
  }

  return  double.parse(totalPrice.toStringAsFixed(2));
}

Future<void> clearCollection() async {
  final QuerySnapshot querySnapshot = await _collectionReference.get();
  final List<DocumentSnapshot> documents = querySnapshot.docs; 
  for (DocumentSnapshot document in documents) {
    await document.reference.delete();
  }
}
 

}




