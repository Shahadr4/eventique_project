



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventique/src/const/size.dart';
import 'package:eventique/src/screen/home/main_home.dart';


import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../../../../../const/color.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    super.key,
  });



  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> { 

  @override
  void initState() {
    // TODO: implement initState
  
    super.initState();
  }

 


  
  final cuser = FirebaseAuth.instance.currentUser!;

   final _nameController = TextEditingController();
   final _phoneController = TextEditingController();
 
  
   //form Key Declare
  final formKey = GlobalKey<FormState>();
  
  updating() {
     
    
    if (_nameController.text.isNotEmpty&&_phoneController.text.isNotEmpty) {
      Map<String, String> dataToUpdate = {'name': _nameController.text,'phone': _phoneController.text,
       
      };

      CollectionReference collection =
          FirebaseFirestore.instance.collection('users');
      DocumentReference document = collection.doc(cuser.uid);
     
      try{
         document.update(dataToUpdate);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeMain(),
            
          ));
          showSucccec("your Profile updated");

      }catch(e){
        showErrorMessage(e.toString()); 

      }

      


    } else {
      showErrorMessage("not updated");
    } 
  }

  // error message to user
  void showErrorMessage(String message) { 
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(behavior: SnackBarBehavior.floating,  backgroundColor: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),  
        
         content: Text(message,style: const TextStyle(color: Colors.red),)));
  }
  void showSucccec(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(behavior: SnackBarBehavior.floating,
        backgroundColor: const Color.fromARGB(255, 3, 3, 3).withOpacity(0.1),  
         
         content: Text(message,style: const TextStyle(color: Color.fromARGB(255, 72, 210, 47)),)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(tDefaultSize),
            child:Form(
              key: formKey,
              child: Column(
                children: [
                  //image box
                  
                   const SizedBox(
                    height: 60,
                  ),
             
                  
                  //username
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Color.fromARGB(255, 6, 6, 6)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:  BorderSide(color: tButtonColor)),
                      prefixIcon: const Icon(Icons.person_outline_outlined),
                      label: const Text("Full Name"),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ), 
                    //username
                 
                  const SizedBox(
                    height: 20,
                  ), 
                  
             
                  TextFormField(
                    
                    keyboardType: TextInputType.number,
                    controller: _phoneController,
                    
                      validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter a Phone Number";
                    } else if (!RegExp(
                            r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
                        .hasMatch(value)) {
                      return "Please Enter a Valid Phone Number";
                    }
                    return null;
                  },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Color.fromARGB(255, 6, 6, 6)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: tButtonColor)),
                      prefixIcon: const Icon(Icons.phone_iphone_rounded),
                      label: const Text("Phone No"),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(  
                    height: 40,
                  ),
                  //button Reset
                  MaterialButton(
                    height: tButtonHeight,
                    onPressed: () { if (formKey.currentState!.validate()){
                      updating();
                    }
                    },
                    color: tButtonColor,
                    child: const Text("Save Profile"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

