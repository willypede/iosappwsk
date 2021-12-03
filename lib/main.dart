import 'package:flutter/material.dart';
import 'package:iosappwsk/pages/home_screen/HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(unselectedWidgetColor: Colors.white,),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}


