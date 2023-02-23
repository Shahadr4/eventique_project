
import 'package:eventique/src/const/color.dart';
import 'package:eventique/src/const/fonts.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:lottie/lottie.dart';


// ignore: must_be_immutable
class SavedAdres extends StatefulWidget {
   SavedAdres({
    
    Key? key,

    this.userId}):super(key: key){
      _reference =FirebaseFirestore.instance.collection("users").doc(userId);
      _referenceAdress=_reference.collection("adress");
    
      
      
      

      


    }

   String? userId;
  
  

  @override
  State<SavedAdres> createState() => _SavedAdresState();

}
 late DocumentReference _reference;
late CollectionReference _referenceAdress;
class _SavedAdresState extends State<SavedAdres>  {

  //controller 
  late final AnimationController _controller;

  bool adressAnim =false;
  
  // text fields' controllers
  final TextEditingController _houseController = TextEditingController();

  final TextEditingController _pinController = TextEditingController();

  final TextEditingController _cityController = TextEditingController();

  final TextEditingController _state = TextEditingController();

  //form Key Declare
  final _formKey = GlobalKey<FormState>();




 

  // This function is triggered when the floatting button or one of the edit buttons is pressed
  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _houseController.text = documentSnapshot['housename'];
      _pinController.text = documentSnapshot['pin'];
      _cityController.text = documentSnapshot['city'];
      _state.text = documentSnapshot['state'];
    }

    await showModalBottomSheet(
        backgroundColor: tButtonColor,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                // prevent the soft keyboard from covering text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Value is Empty';
                      } else {
                        return null;
                      }
                    },
                    controller: _houseController,
                    decoration:
                        const InputDecoration(labelText: 'House housename'),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Value is Empty';
                      } else {
                        return null;
                      }
                    },
                    controller: _cityController,
                    decoration: const InputDecoration(labelText: 'city'),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Value is Empty';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                    controller: _pinController,
                    decoration: const InputDecoration(
                      labelText: 'PinCode',
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Value is Empty';
                      } else {
                        return null;
                      }
                    },
                    controller: _state,
                    decoration: const InputDecoration(labelText: 'state'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: Text(action == 'create' ? 'Create' : 'Update'),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final String? housename = _houseController.text;
                        final String pin = _pinController.text;
                        final String city = _cityController.text;
                        final String state = _state.text;
                        if (housename != null && pin != null && city !=null  && state !=null) {
                          if (action == 'create') {
                            // Persist a new product to Firestore
                            await _referenceAdress.add({
                              "housename": housename,
                              "pin": pin,
                              "city": city,
                              'state': state
                            });
                          }

                          if (action == 'update') {
                            // Update the product
                            await _referenceAdress.doc(documentSnapshot!.id).update({
                              "housename": housename,
                              "pin": pin,
                              "city": city,
                              'state': state
                            });
                          }

                          // Clear the text fields
                          _houseController.text = '';
                          _pinController.text = '';
                          _cityController.text = "";
                          _state.text = '';

                          // Hide the bottom sheet
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  // Deleteing a product by id
  Future<void> _deleteProduct(String productId) async {
    await _referenceAdress.doc(productId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted'))); 
  }
   late bool _isloading;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
     _isloading = true;
    Future.delayed(const Duration(seconds: 3),(){  
      setState(() {
        
        _isloading = false;
      }); 

    }); 
   
    


  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // Using StreamBuilder to display all products from Firestore in real-time
      body: 
       _isloading ?
               Center(
                 child: SpinKitFadingCircle(
                 itemBuilder: (BuildContext context, int index) {
                   return DecoratedBox(
                     decoration: BoxDecoration(
                       color: index.isEven ? Color.fromARGB(255, 237, 236, 236) : Color.fromARGB(255, 0, 0, 0),
                     ),
                   );
                 },
               ),
               ): 
      Stack(
        
        children: [
          Center(child: Lottie.network("https://assets5.lottiefiles.com/packages/lf20_ovwsvehd.json",
          
          )), 
          
          StreamBuilder(
            stream: _referenceAdress.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                    return GlassContainer(
                      height: 240,  
                      width: 340, 
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 196, 182, 182).withOpacity(0.40),
                          Color.fromARGB(255, 153, 149, 149).withOpacity(0.10)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderGradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.60),
                          Colors.white.withOpacity(0.10),
                          Colors.lightBlueAccent.withOpacity(0.05),
                          Colors.lightBlueAccent.withOpacity(0.6)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 0.39, 0.40, 1.0],
                      ),
                      blur: 15.0,
                      borderWidth: 1.5,
                      elevation: 3.0,
                      isFrostedGlass: true,
                      shadowColor: Colors.black.withOpacity(0.20),
                      alignment: Alignment.center,
                      frostedOpacity: 0.12,
                      margin: EdgeInsets.all(8.0),
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column( 
                             
                            children: [
                              SizedBox(height: 20,), 
                              // ignore: prefer_interpolation_to_compose_strings 
                              Text("HouseName: " + documentSnapshot['housename'],
                                  style: tHeading3),
                                  SizedBox(height: 20,), 

                              // ignore: prefer_interpolation_to_compose_strings
                              Text("pin: " + documentSnapshot['pin'],
                                  style: tHeading3),
                                  SizedBox(height: 20,), 

                              Text("city: " + documentSnapshot['city'],
                                  style: tHeading3),
                                  SizedBox(height: 20,), 
                              Text("state: " + documentSnapshot['state'],
                                  style: tHeading3)
                            ],
                          ),

                          // Press this button to edit a single product
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _createOrUpdate(documentSnapshot)),
                          // This icon button is used to delete a single product
                          IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  _deleteProduct(documentSnapshot.id)),
                        ],
                      ),
                    );
                  },
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
      // Add new product
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: tButtonColor,
        onPressed: () => _createOrUpdate(),
        label: Text(
          "Add Adress ",
          style: tHeading3,
        ),
        icon: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }

}


