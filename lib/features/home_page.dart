import 'package:flutter/material.dart';
import 'package:portalixmx_app/res/app_constants.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(child: Text("Welcome to ${AppConstants.appTitle}"),
    );
  }

}