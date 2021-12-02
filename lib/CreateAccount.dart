import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:iosappwsk/LoginScreen.dart';
class CreateAccount extends StatefulWidget {
  const CreateAccount({ Key? key }) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}
class _CreateAccountState extends State<CreateAccount> {  
  DateTime? date;
  String getText(){  
    if(_selectedDate == null){
      return 'Tanggal lahir';
    }else{
      return '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}';
    }
  }

  String getTextDate(){
    
    
    if(date == null){
      return 'Tanggal lahir';
    }else{
      return '${date!.day}/${date!.month}/${date!.year}';
    }
  }

  int _value = 1;
  final TextEditingController _nama = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  DateTime? _selectedDate;
  final TextEditingController _textEditingController = TextEditingController();  
  bool isLoading = false;
  bool isHidePassword = true;
  
  Future register() async{
    /*
    var response = await http.post(Uri.parse("https://warungsatekamu.org/wsk_app_2020/createUser.php"),
    body: {
      "name":_nama.text,
      "email":_email.text,
      "password":_password.text,
      "borndate":_textEditingController.text,
      
    }
    );
    var link = json.decode(response.body);
    */
    print("before create");
    Firebase.initializeApp();
    CollectionReference user =FirebaseFirestore.instance.collection('user');
    String id =user.doc().id;
    await user.doc(id).set({
      "name":_nama.text,
      "email":_email.text,
      "password":_password.text,
      "borndate":_textEditingController.text,
  }, SetOptions(merge: true)).then((value) => print("Data Created"));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                            controller: _nama,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(                                
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Color(0xFFe7edeb),
                              hintText: "Nama",                              
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
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          GestureDetector(
                            onTap: () => _selectDate(),                            
                            child: AbsorbPointer(
                              child: TextField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.datetime,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none, 
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFe7edeb),
                                  hintText: getText(),                                                                  
                              ),
                            ),
                          ),
                          ),
                          Row(
                            children:<Widget> [
                              Radio(
                                value: 1,
                                groupValue: _value,                                 
                                onChanged: (value){
                                  setState(() {
                                   _value = 1; 
                                  });
                                },
                                ),
                                SizedBox(width: 10.0,),
                                Text("Laki-Laki",
                                style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(width: 70.0,),
                              Radio(
                                value: 2,
                                groupValue: _value,
                                onChanged: (value){
                                  setState(() {
                                    _value = 2;
                                  });                                  
                                },
                              ),
                              SizedBox(width: 10.0,),
                              Text("Perempuan",
                              style: TextStyle(color: Colors.white),
                              ),
                              
                              
                            ],
                          ),
                          
                          // Material(
                          //   color: Color(0xFFE1F5FE),
                          //   child: MaterialButton(
                          //     minWidth: MediaQuery.of(context).size.width,
                          //     padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          //     onPressed: (){
                          //     pickDate(context);
                          //     },
                          //     child: Text("Tanggal Lahir",
                          //     textAlign: TextAlign.start,
                          //     style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
                              
                          //     ),
                          //     ),
                          // ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Material(
                            color: Color(0xFF01A0C7),
                            child: MaterialButton(
                              minWidth: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              onPressed: (){
                                print("Daftar");
                                register();
                              },
                              child: Text("DaftarX",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
                              
                              ),
                              ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          GestureDetector(
                              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => LoginScreen())),
                           child: Text(
                             "Sudah Punya Akun?",
                             style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500 ),
                             ),
                         ),
            ],
          )
          ),
          ),
    );
  }
    void _togglePasswordView(){
    setState((){
      isHidePassword = !isHidePassword;      
    });
  }
  _selectDate() async{
      DateTime? pickedDate = await showModalBottomSheet<DateTime>(
        context: context,
       builder: (context) {
        DateTime? tempPickedDate;
        return Container(
          height: 250,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: Text('Done'),
                      onPressed: () {
                        Navigator.of(context).pop(tempPickedDate);
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime dateTime) {
                      tempPickedDate = dateTime;
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _textEditingController.text = pickedDate.toString();
      });
    }
  }

  Future pickDate(BuildContext context) async{
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if(newDate == null) return;

    setState(() => date = newDate);
  }
}


