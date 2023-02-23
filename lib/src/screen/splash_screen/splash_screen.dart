
import 'package:eventique/src/authentication/authentication.dart';

import 'package:flutter/material.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   Future<void> gotoLogin() async{
    await Future.delayed(const Duration(seconds: 3));
    // ignore: use_build_context_synchronously
   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((ctx) => const Authentication())));
  }
  
  
  
  @override
  void initState() {
    // TODO: implement initState
    gotoLogin();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        
        child: Center(child: Image.asset("assets/app_logo.png"))
      ),

    );
    
  }
 
}