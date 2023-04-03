

import 'package:eventique/src/provider/product_provider.dart';
import 'package:eventique/src/provider/user_providers.dart';



import 'package:eventique/src/screen/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [ 
    
       ChangeNotifierProvider.value(value: ProductProvider.initialize()), 
       ChangeNotifierProvider.value(value: UsersProvider.initialize())
     
    ], 
    child:  MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
         scaffoldBackgroundColor: Color.fromARGB(255, 51, 68, 79), 
         
       
         
        

      ),
     
      title: 'eventique',
      home: const SplashScreen(),
    ),
    );
  }
}