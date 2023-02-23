

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screen/home/main_home.dart';
import 'log_reg.dart';


class Authentication extends StatelessWidget  {
  const Authentication({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user Loged In
          if(snapshot.hasData){
            return HomeMain();
          }


          //user not LogedIn
          else{
            return const LoginorRegister();
          }
        },
      ),
      
    );
  }
}  