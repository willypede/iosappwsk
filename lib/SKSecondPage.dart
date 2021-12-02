import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SKSecond extends StatelessWidget {
  
  String name,email,message;
  
  SKSecond({required this.name,required this.email,required this.message});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [
          
            
            Text('Name: ${name}', style: TextStyle(fontSize: 15.0),),
            SizedBox(height: 10.0,),
            Text('Email: ${email}',style: TextStyle(fontSize: 15.0),),
            SizedBox(height: 10.0,),
            Text('Message: ${message}',style: TextStyle(fontSize: 15.0),),
            SizedBox(height: 10.0,),
        
            ElevatedButton(onPressed: () async {
              await sendEmail('email', 'subject', '');
            }, 
            child: Text(
              "Kirim"
            ))
            
          ],
        ),
      )
    );
  }
}
Future<void> sendEmail(String email, String subject, String body) async{
  await launch('mailto:$email?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(body)}');
}