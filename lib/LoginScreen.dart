import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:iosappwsk/CreateAccount.dart';
import 'package:iosappwsk/CustomDialog.dart';
import 'package:iosappwsk/HomeScreen.dart';
import 'package:iosappwsk/LupaPassword.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  bool isHidePassword = true;


String msg = '';
Future<List?> _login() async {
  final response = await http.post(Uri.parse("https://warungsatekamu.org/wsk_app_2020/loginUser.php",
  ), body: {
    "email": _email.text,
    "password": _password.text,
  });
  var data = json.decode(response.body);
  if(data == "No info"){
    Fluttertoast.showToast(
        msg: "Data Not Found!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
    );
  }else{
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => HomeScreen()));
  } 
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center (
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
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
                          TextField(
                            controller: _password,
                            obscureText: isHidePassword,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Color(0xFFe7edeb),
                              hintText: "Password",
                              suffixIcon: InkWell(
                                onTap: _togglePasswordView,
                                child: Icon(
                                  Icons.visibility,
                                ),
                                ),
                              prefixIcon: Icon(Icons.lock,
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
                              _login();
                              },
                              child: Text("MASUK",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
                              ),
                              ),
                          ),                          
                        SizedBox(
                            height: 20.0,
                          ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             GestureDetector(
                              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => LupaPassword())),
                           child: Text(
                             "Lupa Password?",
                             style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500 ),
                             ),
                         ),
                          GestureDetector(
                              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CreateAccount())),
                           child: Text(
                             "Mendaftar",
                             style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500 ),
                             ),
                         ),
                           ],
                         ),
                          SizedBox(
                            height: 30.0,
                          ),
                          // Material(
                          //   color: Color(0xFF1565C0),
                          //   child: MaterialButton(
                              
                          //     minWidth: MediaQuery.of(context).size.width,
                          //     padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          //     onPressed: (){
                                
                          //     Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                          //     },
                              
                          //     child: Text("Masuk dengan Facebook",
                          //     textAlign: TextAlign.center,
                          //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
                              
                          //     ),
                          //     ),
                          // ),
                          
                          Container(
                          width: 400.0,
                          child: TextButton.icon(
                            onPressed: (){},                            
                            icon: Icon(Icons.facebook,
                            color: Colors.white,
                            ),
                            label: Text("Masuk dengan facebook", 
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              backgroundColor: Color(0xFF1565C0),
                              )
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          // Material(
                          //   color: Color(0xFFE1F5FE),
                          //   child: MaterialButton(
                          //     minWidth: MediaQuery.of(context).size.width,
                          //     padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          //     onPressed: (){                                
                          //     Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                          //     },
                          //     child: Text("Sign In",
                          //     textAlign: TextAlign.center,
                          //     style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),                              
                          //     ),
                          //     ),
                          // ),  
                        Container(    
                          width: 400.0,
                        child: TextButton.icon(
                            onPressed: (){},                            
                            icon: Icon(Icons.mail,
                            color: Colors.black,
                            ),
                            label: Text("Sign in", 
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              
                              backgroundColor: Color(0xFFE1F5FE),
                              )
                            ),
                        ),
                          SizedBox(
                            height: 20.0,
                          ),
                          GestureDetector(
                              onTap: () => showDialog(
                                context: context, builder: (context) => CustomDialog(
                                title: "Apakah anda Yakin?",
                                description: "Jika kamu tidak mendaftar, kamu tidak bisa memberikan komentar di tiap-tiap postingan.",                                
                              )
                              ),                          
                           child: Text(
                             "Masuk tanpa mendaftar",
                             style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500 ),
                             ),
                         ),
            ],
          )
        ),
        )
    );
  }
  void _togglePasswordView(){
    setState((){
      isHidePassword = !isHidePassword;      
    });
  }
  
  
}