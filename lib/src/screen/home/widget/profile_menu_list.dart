import 'package:eventique/src/const/color.dart';
import 'package:eventique/src/const/fonts.dart';
import 'package:flutter/material.dart';




class ProfileMenuList extends StatelessWidget {
  const ProfileMenuList({super.key,required this.title,required this.icon,required this.onPress});
  final String title;
  final Widget icon;
  final VoidCallback onPress;
  



  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: tButtonColor.withOpacity(0.3),
          
        ),
        child: icon,
        
      ),
      title: Text(title,style:tHeading2 ,),
      trailing: Container( 
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color:tButtonColor.withOpacity(0.3), 
        ),
        child: const Icon(Icons.arrow_forward_ios_rounded), 
      ),
    );
  }
}