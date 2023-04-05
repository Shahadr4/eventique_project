import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventique/src/model/product.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../const/size.dart';

import '../widget/detials_screen.dart';
import '../widget/product_card.dart';

class Favourite extends StatefulWidget {
  Favourite({
    Key? key,
  }) : super(key: key) {
    _reference = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid);
    _collectionReference = _reference.collection("Favourite");
  }
  @override
  State<Favourite> createState() => _FavouriteState();
}

late DocumentReference _reference;
late CollectionReference _collectionReference;

class _FavouriteState extends State<Favourite> {
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
        title: Center(
            child: Text(
          'Favourite screen',
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
            return GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              childAspectRatio: 0.6,
              children:
                  List.generate(streamSnapshot.data!.docs.length, (index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];

                return Padding(
                  padding: const EdgeInsets.all(tDefaultSize),
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      ProductCard(
                          title: documentSnapshot['name'],
                          image: documentSnapshot['image'],
                          price: documentSnapshot['price'],
                          press: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    productDetails: Product(
                                     
                                      title: documentSnapshot['name'],
                                      image: documentSnapshot['image'],
                                      price: documentSnapshot['price'],
                        
                                      gender: documentSnapshot['gender'],
                                      description: documentSnapshot['description']
                                    ),
                                  ),
                                ));
                          }),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12),
                                bottomLeft: Radius.circular(12)),
                            color: Color.fromARGB(255, 255, 255, 255),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  offset: Offset(1, 4),
                                  blurRadius: 6)
                            ]),
                        child: IconButton(
                            onPressed: () async {
                              await _collectionReference
                                  .doc(documentSnapshot.id)
                                  .delete();
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 20,
                            )),
                      )
                    ],
                  ),
                );
              }),
            );
          }

          return Center(child: Text("Its empty in here"));
        },
      ),
    );
  }
}
