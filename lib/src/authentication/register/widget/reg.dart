import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventique/src/const/fonts.dart';
import 'package:eventique/src/const/size.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:image_cropper2/image_cropper2.dart';
import 'package:image_picker/image_picker.dart';

import 'package:glass/glass.dart';

import '../../../const/color.dart';

class Register extends StatefulWidget {
  final void Function()? ontap;

  const Register({super.key, required this.ontap});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _nameController = TextEditingController();

  final _passwordController = TextEditingController();

  final _userEmailController = TextEditingController();
  final _phoneController = TextEditingController();

  final _repasswordController = TextEditingController();
  File? imageFile;
  String? imgUrl;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  //form Key Declare
  final _formKey = GlobalKey<FormState>();

  //<<<<<<<<<Register function>>>>>>>>
  Future<void> userRegister() async {
    //Firebase Authentication(Try register+ and also cathc error)
    try {
      //password checking with confirm password
      if (_passwordController.text == _repasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _userEmailController.text.trim(),
            password: _passwordController.text.trim() ,


            
            );
        final ref =FirebaseStorage.instance.ref().child('userImages/profile').child(users.id+".jpg");
        await ref.putFile(imageFile!);
        imgUrl= await ref.getDownloadURL();

        createUserInFireStore();
        showErrorMessage("Registeration completed");
  
        //adding cloudStor
      } else {
        showErrorMessage("Passwords don't match!");
      }
    } on FirebaseAuthException catch (e) {
      // show error message
      showErrorMessage(e.code);
    }
  }

  void createUserInFireStore() {
    final userDoc = FirebaseAuth.instance.currentUser!;

    Map<String, dynamic> userDetails = {
      'name': _nameController.text,
      'email': _userEmailController.text,
      'phone': _phoneController.text, 
      'uid': userDoc.uid,   
      'imageUrl':imgUrl,
      'create at':Timestamp.now()

    };

    users.doc(userDoc.uid).set(userDetails);
  }

  //getfromcamera
  void getFromCamera() async {
    XFile? pickFile = await ImagePicker().pickImage(source: ImageSource.camera,);
    cropImage(pickFile!.path);
    Navigator.pop(context);
  }

  //getfromcamera 
  void getFromGallery() async {
    XFile? pickFile =
        await ImagePicker().pickImage(source: ImageSource.gallery,);
    cropImage(pickFile!.path);
    Navigator.pop(context);
  }

  //cropImage

  void cropImage(filepath) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: filepath, );   

    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
  }

  //showimageDailog
  void imagePick() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          surfaceTintColor: Colors.transparent, 
          title: Text("Please choose an option"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  //creategetFrom Camera
                  getFromCamera();
                },
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.camera_alt_rounded),
                    ),
                    Text("camera")
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  //creategetFrom gallery
                  getFromGallery();
                },
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.image),
                    ),
                    Text("Gallery")
                  ],
                ),
              )
            ],
          ),
        ) .asGlass(
                  tintColor: Color.fromARGB(255, 65, 64, 64),
                  clipBorderRadius: BorderRadius.circular(23),
                 );
      }  
    );
  } 

  // error message to user
  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 500),  
          behavior: SnackBarBehavior.floating, content: Text(message)));
  }

  bool _isVisible = true;
  //obscure true ayal password hideakopm
  void updateStatus() {
    //
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: SafeArea(
        child: SingleChildScrollView(
           
          child: Padding(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Form(
              key: _formKey, 
              child: Column( 
                
                children: [
                GestureDetector(
                  onTap: () {
                    imagePick(); 
                  },
                  child: Container(
                                 width: 110,
                      height: 110,  
                      decoration: imageFile == null
                          ? BoxDecoration( 
                            
                           
                            shape: BoxShape.circle,
                            
                            
                              image: DecorationImage(
                                
                                
                                  image: AssetImage("assets/Avathar.png",),
                                  fit: BoxFit.contain))
                          : BoxDecoration(
                            shape: BoxShape.circle,  
                              image: DecorationImage(
                                fit: BoxFit.cover,         
                                  image: Image.file(imageFile!).image),)
                                  )
                 
                ),
                const SizedBox(
                  height: 20,
                ), 
                Center(child: Text("Tap to change picture",style: tHeading3,)), 
        
                const SizedBox(
                  height: 20,
                ),
        
                const SizedBox(
                  height: 40,
                ),
                //userName
                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Value is Empty';
                    } else if (value.length < 4) {
                      return 'Name too short';
                    } else {
                      return null;
                    }
                  },
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
                    label: const Text("Full name "),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
        
                //Email
                TextFormField(
                  controller: _userEmailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Value is Empty';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color.fromARGB(255, 6, 6, 6)),
                      borderRadius: BorderRadius.circular(12), 
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:  BorderSide(color: tButtonColor)),
                    prefixIcon: const Icon(Icons.email_outlined),
                    label: const Text("E-Mail"),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //phonel
        
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
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
                        borderSide:  BorderSide(color: tButtonColor)),
                    prefixIcon: const Icon(Icons.phone_android_rounded),
                    label: const Text("Phone"),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Value is Empty';
                    } else if (value.length < 4) {
                      return 'Username too short';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color.fromARGB(255, 6, 6, 6)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:  BorderSide(color: tButtonColor)),
                    prefixIcon: const Icon(Icons.fingerprint_outlined),
                    label: const Text("Password"),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
        
                TextFormField(
                  controller: _repasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Value is Empty';
                    } else {
                      return null;
                    }
                  },
                  obscureText: _isVisible ? true : false,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Color.fromARGB(255, 6, 6, 6)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: tButtonColor)),
                      label: const Text("Confirm-Password"),
                      prefixIcon: const Icon(Icons.security_outlined),
                      suffixIcon: IconButton(
                          onPressed: (() => updateStatus() //call cheytho
                              ),
                          icon: Icon(_isVisible
                              ? Icons.visibility_off
                              : Icons.visibility)),
                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: tButtonHeight,
                  child: ElevatedButton.icon(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 48, 48, 48)),
                    onPressed: () {
                      if(imageFile == null){
                        showErrorMessage("please Select an Image");
                      }else {
                         if (_formKey.currentState!.validate()) {
                        
                        userRegister();
                      } 
        
                      }
                     
                    },
                    icon: const Icon(Icons.login),
                    label: const Text("Register"),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'not a member?',
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                        onPressed: widget.ontap,
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.black),
                        )),
                  ],
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
