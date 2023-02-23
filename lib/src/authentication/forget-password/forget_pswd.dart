import 'package:eventique/src/const/color.dart';
import 'package:eventique/src/const/size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  final _email =TextEditingController();
  //dispose
  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    _email.dispose();
    super.dispose();
  }

  Future resetPasswd() async{
     try{
      //resetting password
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email.text.trim());

       showDialog(context: context, builder: (context) {
        return const AlertDialog(
          content: Text("Password reset link sent!Check your Email"),
        );
        
      },);

     }on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(behavior: SnackBarBehavior.floating, content: Text(e.message.toString())));

    
     }

  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      
      body: Padding(
        padding:  const EdgeInsets.all(tDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Enter your E-Mail and we will send a password reset link",
            textAlign: TextAlign.center,
            style: GoogleFonts.abel(
              fontSize: 30
            ),),
            const SizedBox(height: 20,),

          //email textform
           TextField(
                        controller: _email,
                        decoration: InputDecoration(

                          prefixIcon: const Icon(Icons.person_outline_outlined),
                          label:  Text("E-mail ",style: TextStyle(
                            color: tButtonColor
                          ),), 
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color.fromARGB(255, 6, 6, 6)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:  BorderSide(color:tButtonColor)
                          ),
                        ),
                      ),
                      const SizedBox(height: 25,), 

            //button Reset
             MaterialButton(
              height: tButtonHeight,
              onPressed:resetPasswd,
             color:tButtonColor, child: const Text("Reset Password"),
             
             ),

            

                      

          ],
        ),
      ),
    );
  }
}