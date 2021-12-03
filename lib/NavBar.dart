

import 'package:flutter/material.dart';
import 'package:iosappwsk/DukungKami.dart';
import 'package:iosappwsk/DuniaPage.dart';
import 'package:iosappwsk/pages/home_screen/HomeScreen.dart';
import 'package:iosappwsk/IsuKehidupan.dart';
import 'package:iosappwsk/KirimKarya.dart';
import 'package:iosappwsk/KomunitasPage.dart';
import 'package:iosappwsk/LockScreen.dart';
import 'package:iosappwsk/LoginScreen.dart';
import 'package:iosappwsk/Opini.dart';
import 'package:iosappwsk/Pengaturanmain.dart';
import 'package:iosappwsk/PersonalPage.dart';
import 'package:iosappwsk/ProyekSaatTeduhPage.dart';
import 'package:iosappwsk/RSKScreen.dart';
import 'package:iosappwsk/SantapanRohaniPage.dart';
import 'package:iosappwsk/Siapakami.dart';
import 'package:iosappwsk/TuhanPage.dart';

class NavBar extends StatelessWidget {
  String? valueChoose;
  List listItem1 = [
    "SANTAPAN ROHANI","PROYEK SAAT TEDUH"
  ];
  @override
  Widget build(BuildContext context) {
    
    return Drawer(    
      child: ListView(        
        padding: EdgeInsets.zero,       
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Ryan Kurnia'),
            accountEmail: Text('example@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipRRect(
                child: Image.network(
                  'https://spesialis1.orthopaedi.fk.unair.ac.id/wp-content/uploads/2021/02/depositphotos_39258143-stock-illustration-businessman-avatar-profile-picture.jpg',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            ),
          
            ListTile(
              title: Text('HOME'),
              onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen())),
              
            ),
            ListTile(
              
              title: Text('LIKED POST'),
              onTap: () => null,
            ),
            ExpansionTile(
              title: Text("SAAT TEDUH"),
              children: <Widget>[
                ListTile(title: Text("SANTAPAN ROHANI"), onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_) => SRPage())),),
                ListTile(title:Text("PROYEK SAAT TEDUH"),onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_) => PSTPage())),),
              ],
              ),
              ExpansionTile(
              title: Text("ARTIKEL"),
              children: <Widget>[
                ListTile(title: Text("TUHAN"),onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_) => TuhanPage())),),
                ListTile(title:Text("PERSONAL"),onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_) => PersonalPage())),),
                ListTile(title:Text("KOMUNITAS"),onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_) => KomunitasPage())),),
                ListTile(title:Text("DUNIA"),onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_) => DuniaPage())),),
                ListTile(title:Text("ISU KEHIDUPAN"),onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_) => IKPage())),),
                ListTile(title:Text("OPINI"),onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_) => OpiniPage())),),
              ],
              ),
            ListTile(
              
              title: Text('RUANG SENI KAMU'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RSKPage())),
            ),
            ListTile(
              
              title: Text('LOCKSCREEN'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LockScreenPage())),
            ),
            ListTile(
              
              title: Text('SIAPA KAMI'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SiapaKami())),
            ),
            ListTile(
              
              title: Text('PENGATURAN'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PengaturanHome())),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('DUKUNG KAMI'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DukungKami())),
            ),
            ListTile(
              leading: Icon(Icons.mail),
              title: Text('KIRIM KARYA'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => KirimKarya())),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen())),
            ),
              ],
            ),
          
    );
  }
}

