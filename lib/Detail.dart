import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iosappwsk/NavBar.dart';
import 'package:flutter_html/flutter_html.dart';

class Detail extends StatefulWidget {
  Map data;
  late int index;
  
    Detail(this.data);
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail>  {
  final TextEditingController commentController = TextEditingController();

 Future<dynamic> getDetail() async {
  print("before");
  final response = await http.post(Uri.parse("https://warungsatekamu.org/wsk_app_2020/loadContent.php",
  ), body: {
    "id": widget.data["id"]
  });
  print("id : "+widget.data["id"].toString());
  var data = json.decode(response.body);
  //print(data.content);
  //var test=1;
  //print("mulai");
  //String temp=data["content"];
  //print(data["content"]);
  //print("selesai");
  return data["content"];
}
Future<dynamic> getComment() async {
  print("before");
  final response = await http.post(Uri.parse("https://warungsatekamu.org/wsk_app_2020/loadComments.php",
  ), body: {
    "id": widget.data["id"]
  });
  
  var data = json.decode(response.body);
  int test=1;
  //print("hasil detail comment "+data.toString());
  return data;
}

Widget ListDetailDetail(Map data,int index)
  {
    return SingleChildScrollView(child:Card(child: Column(children: [
      Container(child: Text(data["name"], )), Container(child: Text(data["comment"],style: TextStyle(color: Colors.blue),),)
      ]
      )));
  }
  
  var list = [];

  Widget getData()
  {
     return FutureBuilder(
        builder: (context, data) {
          print("mulai");
          print(data.data.toString());
          print("finish");
          if (data.hasData) {
            return Html(data:data.data.toString());
          } else {
            return Center(child: Text("Loading"));
          }          
        },
        future: getDetail());
  }
 
  Widget getComments()
  {
    return FutureBuilder(
      builder: (context, data){
        if(data.hasData){
          list = data.data as List<dynamic>;
            print(list.toString());
            if (list.length <= 0) {
              return Center(child: Text("Tidak ada comment"));
        } else{
          print("list");
          return SingleChildScrollView(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map cat = list[index];
                        print(cat);
                        return ListDetailDetail(cat, index);
                      }
                  ),
              ],
            ),
            );

        }
        }else{
          return Center(child: Text("Loading"));
        }
        
        },
        future: getComment()
    );
  }
  @override
  Widget build(BuildContext context) { 
    return Scaffold(      
      backgroundColor: Colors.white,
      drawer: NavBar(),
      appBar: AppBar(
       
        centerTitle: true,
        title: Text(
          widget.data['category'],
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.favorite_border),
            )

        ],
        ),
       body:
       SingleChildScrollView(
       child: Column(children: [           
         new Image.network(
         widget.data['image']
       ),
       
       Container(
         padding: const EdgeInsets.all(20.0),
         child: Row(
           children: [
             new Expanded(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Container(
                     padding: const EdgeInsets.only(bottom: 5.0),
                     child: Text(
                       'Judul: ' + widget.data['title'],
                       style: new TextStyle(fontWeight: FontWeight.bold),
                     ),
                   ),
                   Text(
                     'Tanggal :' + widget.data['date'],
                     style: TextStyle(color: Colors.red),
                   ),
                 ],
               )
               ),
           ],
         )
       ),
      
       getData(),
       Container(
          width: 500.0,
          height: 42.0,
          decoration: BoxDecoration(
            color: Colors.blue,          
          ),
          child: Center(
            child: Text(
              'Komentar',
              style: TextStyle(
                
                fontSize: 18,
                color: Colors.white,
                height: 1,
              ),
              
            ),
          ),
        ),
       SizedBox(
         height: 20.0,
       ),
       Container(
         child: TextField(
           decoration: const InputDecoration(
             border: OutlineInputBorder(),
             hintText: "Enter Comment Here",
             
           ),
         )
         
       ),
       
       getComments(),
       
        ],
        
      ),
      
      ),
       
    );
  }
}

