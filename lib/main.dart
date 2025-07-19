import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matri_station/ui/dashboard_screen.dart';
import 'package:matri_station/ui/formfillup/basic_details_screen.dart';
import 'package:matri_station/ui/login_screen.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      home: LoginScreen(),

    );
  }
}
