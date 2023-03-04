
import 'package:eventique/src/const/color.dart';
import 'package:eventique/src/model/cart.dart';
import 'package:eventique/src/model/product.dart';
import 'package:eventique/src/screen/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
if(!Hive.isAdapterRegistered(ProductAdapter().typeId)){
  Hive.registerAdapter(ProductAdapter());
}
  
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => Cart(),
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