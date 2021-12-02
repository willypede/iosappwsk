import 'package:flutter/material.dart';

class LupaPassword extends StatefulWidget {
  const LupaPassword({ Key? key }) : super(key: key);

  @override
  _LupaPasswordState createState() => _LupaPasswordState();
}

class _LupaPasswordState extends State<LupaPassword> {
  final TextEditingController _email = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center (
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 130.0,
                child: Image.asset("assets/logo_wsk_white_hires.png",
                
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
                        TextField(
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Color(0xFFe7edeb),
                              hintText: "E-Mail",
                              prefixIcon: Icon(Icons.email,
                              color: Colors.grey,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Material(
                            color: Color(0xFF01A0C7),
                            child: MaterialButton(
                              minWidth: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              onPressed: (){
                                
                              
                              },
                              child: Text("KIRIM LINK VERIFIKASI",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
                              
                              ),
                              ),
                          ),
            ],
          ),
          ),
          ),
    );
  }
}