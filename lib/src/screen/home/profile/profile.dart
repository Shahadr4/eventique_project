import 'dart:io';

import 'package:eventique/src/provider/user_providers.dart';
import 'package:eventique/src/screen/home/orderList/orders_list.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventique/src/const/color.dart';
import 'package:eventique/src/const/fonts.dart';
import 'package:eventique/src/const/size.dart';



import 'package:firebase_auth/firebase_auth.dart';
// ignore: library_prefixes
import 'package:firebase_storage/firebase_storage.dart' as fStrorage;
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:glass/glass.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper2/image_cropper2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../adress/saved_adress.dart';
import '../widget/editProfile/edit_profile.dart';
import '../widget/profile_menu_list.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  const Profile({
    super.key,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = FirebaseAuth.instance.currentUser!;

  CollectionReference cUser = FirebaseFirestore.instance.collection('users');

  CollectionReference cAdress = FirebaseFirestore.instance.collection('adress');

 

  
  String name ='';
  
  File? imageXFile ;
   
  String? userImageUrl;  
  final imagePicker =ImagePicker(); 

  late bool _isloading;
  @override
  void initState() {
    // ignore: todo 
    // TODO: implement initState 
    super.initState();
      getDataFromDatabase();
      updateProfileImageonUserExitPst(); 
     

    _isloading = true;
    Future.delayed(const Duration(seconds: 1),(){     
      setState(() {
        
        _isloading = false;
        
      }); 

    });
    
   
    
    
  
    
   

  }

  Future getDataFromDatabase() async {
    
 
       await cUser.doc(user.uid).get().then((snapshot) async {
     
       if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;       

        setState(() {
           
          name = data['name'];
        
        });
      }  

        
    
    
    }); 
 
    
  }

  void updateprofilePic()async{

   
    fStrorage.Reference reference=fStrorage.FirebaseStorage.instance.ref().child('userImages/profile').child("${user.email} .jpg");
    fStrorage.UploadTask uploadTask=reference.putFile(File(imageXFile!.path)); 

    fStrorage.TaskSnapshot taskSnapshot=await uploadTask.whenComplete(() {});
    
    await taskSnapshot.ref.getDownloadURL().then((url)async{
       userImageUrl = url;


    } );
    await FirebaseFirestore.instance.collection("users").doc(user.uid).update({
      'imageUrl':userImageUrl
      
    }).whenComplete(() { 
      updateProfileImageonUserExitPst();

    });
  }

  //when updation completed then changing photo
  updateProfileImageonUserExitPst() async{
    await FirebaseFirestore.instance.collection("users").where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid).
    get().then((snapshot){
     for(int index=0; index<snapshot.docs.length; index++){
      String userimagepost=snapshot.docs[index]['imageUrl'];
      if(userimagepost != userImageUrl){
        FirebaseFirestore.instance.collection("users").doc(snapshot.docs[index].id).update(
          {
            'imageUrl':userImageUrl, 

          }
        );
      }

     }

    }
    );

  }

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        duration: const Duration(milliseconds: 400),
        content: Text(
          message,
          style: const TextStyle(color: Color.fromARGB(255, 233, 232, 232)),
        )));
  }
  //getfromcamera
  void getFromCamera() async {
    XFile? pickFile = await ImagePicker().pickImage(source: ImageSource.camera,);
     cropImage(pickFile!.path);  
    
    // ignore: use_build_context_synchronously 
    Navigator.pop(context);
  }

  //getfromcamera 
  void getFromGallery() async { 
    XFile? pickFile =
        await ImagePicker().pickImage(source: ImageSource.gallery,); 
        cropImage(pickFile!.path);
   
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  //cropImage

  void cropImage(filepath) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: filepath,maxHeight: 1080,maxWidth: 1080 );    

    if (croppedImage != null) {
      setState(() {
        imageXFile = File(croppedImage.path);
        updateprofilePic();
      });
    }
  }
  

  //showimageDailog
  void imagePick() {
    showDialog( 
      context: context,
      builder: (context) {
        return AlertDialog(
         
          title: const Text("Please choose an option"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  //creategetFrom Camera
                  getFromCamera();
                },
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.camera_alt_rounded),
                    ),
                    const Text("camera")
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  //creategetFrom gallery
                  getFromGallery();
                },
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.image),
                    ),
                    const Text("Gallery")
                  ],
                ),
              )
            ],
          ),
        ) .asGlass(
                  tintColor: const Color.fromARGB(255, 65, 64, 64),
                  clipBorderRadius: BorderRadius.circular(23),
                 );
      }  
    );
  } 




  @override
  Widget build(BuildContext context) {
    final productprovider = Provider.of<UsersProvider>(context);
    productprovider.getUser();
 
    var userData=productprovider.currentUser;

    //logout 
    void logout() {
      FirebaseAuth.instance.signOut();
    }

    return Scaffold( 
      backgroundColor: Color.fromARGB(255, 204, 204, 204),
       
      extendBody: true, 
      body: SafeArea(
        child: 
           
        SingleChildScrollView( 
          physics: const NeverScrollableScrollPhysics(), 
          child: Padding(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
             
              children: [
                 
                Stack(
                  alignment: Alignment.bottomCenter,  
                  
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black, 
                     
                      radius: 68,
                      child:_isloading ?
               Center(
                 child: SpinKitFadingCircle(
                 itemBuilder: (BuildContext context, int index) {
                   return DecoratedBox(
                     decoration: BoxDecoration(
                       color: index.isEven ? Color.fromARGB(255, 237, 236, 236) : Color.fromARGB(255, 0, 0, 0),
                     ),
                   );
                 },
               ),
               ):  CircleAvatar(
                        backgroundColor: Colors.white, 
                       
                       radius: 66, 
                        backgroundImage:
                        imageXFile == null    ? NetworkImage(userData!.image)
                        :
                        Image.file(imageXFile!).image, 
                        
                      ),
                    ),
                    Positioned(
                    left:96,   
                        
                      child: CircleAvatar(
                        backgroundColor: tButtonColor,  
                        child:  GestureDetector(
                              onTap: () {
                                imagePick(); 
                                
                                  
                              },
                              child: const Center(
                                  child: Icon(Icons.camera_alt_rounded,color: Color.fromARGB(255, 255, 255, 255),)),
                             ),
                           
                        
                      ),
                    )
                    


                   
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                Text( 
                  userData!.name,  
                  style: tHeading1,
                ),
                Text(
                  'Phone: '+userData.phone ,
                  style: GoogleFonts.workSans(fontSize: 20),
                ),

                Text(
                  " email: ${user.email}",
                  style: tHeading2,
                ),
                const SizedBox(
                  height: 50,
                ),

                // edit profile button
                SizedBox(
                  height: tButtonHeight,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfile(),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: tButtonColor,
                        side: BorderSide.none,
                        shape: const StadiumBorder()),
                    child: Text(
                      "Edit Profile",
                      style: tHeading2,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                const Divider(
                  thickness: 0.1,
                ),
 
                //menuLit____

                //order
                ProfileMenuList(
                  title: "Order",
                  icon: Lottie.network("https://assets5.lottiefiles.com/packages/lf20_gBPGEvXqJu.json"),
                  onPress: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OrdersList(index: 1),));
                  }, 
                ),

                const SizedBox(
                  height: 30,
                ),

                //Adress
                ProfileMenuList(
                  title: "Saved Address",
                  icon: Lottie.network("https://assets10.lottiefiles.com/packages/lf20_UgZWvP.json"), 
                  
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SavedAdres(
                            userId: user.uid,
                          ),
                        ));
                  },
                ),
                const SizedBox(
                  height: 60,
                ),

                //logout Buttton
                SizedBox(
                  height: tButtonHeight,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: logout,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 67, 65, 65),
                        side: BorderSide.none,
                        shape: const StadiumBorder()),
                    child: Text(
                      "Logout ",
                      style: GoogleFonts.alfaSlabOne(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                //logo
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        thickness: 0.7,
                        color: Colors.grey,
                      ),
                    ),
                    Image.asset(
                      "assets/app_logo.png",
                      height: 50,
                    ),
                    const Expanded(
                      child: Divider(
                        thickness: 0.7,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
