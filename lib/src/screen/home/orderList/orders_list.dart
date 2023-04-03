import 'package:eventique/src/provider/user_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class OrdersList extends StatelessWidget {
   OrdersList({super.key,  this.index});
  int? index;

  @override
  Widget build(BuildContext context) {
    final productprovider = Provider.of<UsersProvider>(context);

    productprovider.getUser();
    var userData=productprovider.currentUser;

    return  Scaffold(
      body: Center(child: Text(userData!.name)), 
    );
  }
}