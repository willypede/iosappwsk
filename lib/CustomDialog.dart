import 'package:flutter/material.dart';
import 'package:iosappwsk/CreateAccount.dart';
import 'package:iosappwsk/pages/home_screen/HomeScreen.dart';

class CustomDialog extends StatelessWidget {
  late final String title, description;
  CustomDialog({required this.title, required this.description});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 16,
            bottom: 16,
            left: 16,
            right: 16,
          ),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(17),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.blue,
                )
              ),
              ),
              SizedBox(height: 20.0,),
              Text(description, style: TextStyle(fontSize: 16.0,)),
              SizedBox(height: 24.0),
              Row(
              children:<Widget>[
              SizedBox(width: 60.0), 
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => HomeScreen()));
                  },
                  child: Text("TETAP MASUK"),
                ),
                
                ),
                Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => CreateAccount()));
                  },
                  child: Text("MENDAFTAR"),
                ),
                
                ),
              ],
              ),
                
            ]
          ) 
        )
      ],
    );
  }
}