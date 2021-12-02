import 'package:flutter/material.dart';
import 'package:iosappwsk/Pengaturan.dart';
import 'package:iosappwsk/NavBar.dart';

class PengaturanHome extends StatefulWidget {
  

  @override
  _PengaturanHomeState createState() => _PengaturanHomeState();
}

class _PengaturanHomeState extends State<PengaturanHome> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        backgroundColor: Colors.white,
       drawer: NavBar(),
        appBar: AppBar(
          title: Text("Pengaturan"),
          backgroundColor: Colors.red,
        ),
      body: Container(
        alignment: Alignment.center,
        child: Reminder(),
        )
    );
  }
}