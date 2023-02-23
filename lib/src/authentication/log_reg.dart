import 'package:eventique/src/authentication/login/login.dart';

import 'package:eventique/src/authentication/register/widget/reg.dart';

// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';

class LoginorRegister extends StatefulWidget {
  const LoginorRegister({super.key});

  @override
  State<LoginorRegister> createState() => _LoginorRegisterState();
}

class _LoginorRegisterState extends State<LoginorRegister> {
  //show login Initialy
  bool showLoginPage=true;

  //toggle between login and register page
  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
   if(showLoginPage){
    return Login(onTap: togglePages);
   }else{
    return Register(ontap: togglePages,);
   }
  }
}