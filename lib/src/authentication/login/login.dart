

import 'package:eventique/src/authentication/forget-password/forget_pswd.dart';

import 'package:eventique/src/authentication/login/widgets/squareTile.dart';
import 'package:eventique/src/authentication/services/firebase_auth_services.dart';
import 'package:eventique/src/const/color.dart';
import 'package:eventique/src/const/size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  final void Function()? onTap;
  const Login({super.key, required this.onTap});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  

  //form Key
  final _formKey = GlobalKey<FormState>();

  //<<<<<-----LOGIN FUNCTION >>>>>>>>>>>>>>>>>
  Future<void> userSignIn() async {
    //Firebase Authentication(Try login+ and also cathc error)
    showDialog(context: context, builder:(context) {
      return const Center(child: CircularProgressIndicator());
      
    },);


    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text, password: _password.text);
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();

          showSucccec("You are logged In");

          
    } on FirebaseAuthException catch (e) {
      // show error message
      showErrorMessage(e.code);
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
         
         content: Text(message,style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),)));
  }

  bool _isVisible = true; //obscure true ayal password hideakopm 
  void updateStatus() {
    //
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
    
      child: Container(
        padding: const EdgeInsets.all(tDefaultSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //logo
            Image.asset( 
              "assets/app_logo.png",
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            const SizedBox(
              height: 40,
            ),

            Text(
              "WELCOME ",
              style: GoogleFonts.notoSerif(fontSize: 40),
            ),

            //<--------form part -------------->
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Value is Empty';
                          } else {
                            return null;
                          }
                        }, 
                        decoration:  InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color.fromARGB(255, 6, 6, 6)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:  BorderSide(color:tButtonColor)
                          ),
                          
                          prefixIcon: const Icon(Icons.person_outline_outlined),
                          label: const Text("E-mail "),
                          border: const OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      //password
                      TextFormField(
                        controller: _password,
                        obscureText: _isVisible
                            ? true
                            : false, //obscure true ayal password hideakopm
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Value is Empty';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color.fromARGB(255, 6, 6, 6)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:  BorderSide(color:tButtonColor)
                          ),
                            prefixIcon: const Icon(Icons.fingerprint_outlined),
                            label: const Text("Password "),
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: () => updateStatus(),
                              icon: Icon(_isVisible 
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            )),
                      ),

                      //FORGET PASSWORD
                      const SizedBox(
                        height: 2,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForgetPassword(),
                                  ));
                            },
                            child: const Text("Forget Pasword?")),
                      ),

                      //LOGIN BUTTON
                      SizedBox(
                        
                        height: tButtonHeight,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: tButtonColor,
                          ),
                          
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                userSignIn();
                              }
                            },
                            child: Text("LOGIN")),
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: Colors.grey,
                            ),
                          ),
                          const Text("Or Continue with"),
                          const Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          TextButton(
                            onPressed:() => FirebaseAuthServices().signInWithGoogle(),
                            child: const SquareBox(
                                imagepath:"assets/Google.png",
                            )
                          )
                        ],
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
                              onPressed: widget.onTap,
                              child: const Text(
                                "Register Now",
                                style: TextStyle(color: Colors.black),
                              )),
                        ],
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    ));
  }
}


