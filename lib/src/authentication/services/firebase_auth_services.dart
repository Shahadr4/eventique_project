

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class FirebaseAuthServices{


  //Google Login
  signInWithGoogle()async{

    //begon intractive Sign In  Process
    final GoogleSignInAccount? gUser= await GoogleSignIn().signIn();



    //obtain auth details from requeest
    final GoogleSignInAuthentication gAuth= await gUser!.authentication;



    //create new credeptiol for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken
    );

    //finslly signIn>>>>>>>>>>

    return await FirebaseAuth.instance.signInWithCredential(credential);




  }


  
  




  
}