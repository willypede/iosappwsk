import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iosappwsk/Detail.dart';
import 'package:iosappwsk/NavBar.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:carousel_slider/carousel_slider.dart';
class OpiniPage extends StatefulWidget {
  List? list;
  late int index;

  @override
  _OpiniPageState createState() => _OpiniPageState();
}

class _OpiniPageState extends State<OpiniPage> {
  void initState() {
    super.initState();

    getGambar();
    
  }
   List imgList = [];
  Future<List?> getGambar() async {
  print("before");
  final response = await http.post(Uri.parse("https://www.warungsatekamu.org/wsk_app_2020/load1Opini.php",
  ), body: {
  });
  //print("hasil "+response.body.toString());
  var data = json.decode(response.body);
  imgList=data;
  setState(() {
    
  });
  }


  Future<List?> getOpini() async {
    print("before");
    final response = await http.post(
        Uri.parse(
          "https://warungsatekamu.org/wsk_app_2020/loadOpini.php",
        ),
        body: {"limit": "0"});
    print("hasil " + response.body.toString());
    var data = json.decode(response.body);
    list=data;
  setState(() {
    
  });
  }

  var list = [];
  Widget ListDetail(Map data, int index) {
    return InkWell(
        onTap: () async {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Detail(data)));
          //print("click "+data.toString());
        },
        child: Column(children: [
          Image.network(data["image"],
              height: 130, width: 300, fit: BoxFit.fill),
          Container(child: Text(data["title"])),
          Container(
              child: Text(
            data["date"],
            style: TextStyle(color: Colors.grey),
          ))
        ]));
  }

  loadMoreOpini() async {
    final response = await http.post(
        Uri.parse(
          "https://warungsatekamu.org/wsk_app_2020/loadOpini.php",
        ),
        body: {"limit": "10"});
    print("hasil " + response.body.toString());
    var data = json.decode(response.body);
    for (var i = 0; i < data.length; i++) {
      list.add(data[i]);
    }
    setState(() {});
    //print("Load More");
  }
Widget getData(){
    if (first)
       {
         getOpini();
         first=false;
       }
       return LazyLoadScrollView(
                      onEndOfPage: () => loadMoreOpini(),
                      child:  GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map cat = list[index];
                        print(cat);
                        return ListDetail(cat, index);
                      },
                    ),
                    );
  }
  @override
  bool first = true;
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: NavBar(),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "WarungSaTeKaMu",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
           Container(
                  
                  width:   double.infinity,
                  child: CarouselSlider(
                  
                  options: CarouselOptions(),
                  items: imgList
                      .map((item) => Container(
                            width:   double.infinity,
                            child: 
                              InkWell(
                              onTap: () async {
                                        Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => Detail(item)));
                                      //print("click "+data.toString());
                                    },
                              child:
                            Stack(children: <Widget>
                            [
                              Center(
                                child:
                                    Image.network(item["image"], fit: BoxFit.cover, width: double.infinity)
                                    ),
                              Center(
                                child: Text(item["title"],
                                 style: TextStyle(color: Colors.black)
                                ),
                              )
                            ],))
                          
                          ))
                      .toList(),
                )),
            Expanded(
              child: getData()

                // child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: FutureBuilder(
                //         builder: (context, data) {
                //           if (data.hasData) {
                //             list = data.data as List<dynamic>;
                //             print(list.toString());
                //             if (list.length <= 0) {
                //               return Center(
                //                   child: Text("Tidak ada saat teduh"));
                //             } else {
                //               print("list");
                //               return LazyLoadScrollView(
                //                 onEndOfPage: () => loadMoreOpini(),
                //                 child: GridView.builder(
                //                   gridDelegate:
                //                       SliverGridDelegateWithFixedCrossAxisCount(
                //                           crossAxisCount: 2),
                //                   scrollDirection: Axis.vertical,
                //                   shrinkWrap: true,
                //                   itemCount: list.length,
                //                   itemBuilder:
                //                       (BuildContext context, int index) {
                //                     Map cat = list[index];
                //                     print(cat);
                //                     return ListDetail(cat, index);
                //                   },
                //                 ),
                //               );
                              // return SingleChildScrollView(
                              //   child: Column(
                              //     mainAxisAlignment: MainAxisAlignment.start,
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //        LazyLoadScrollView(
                              //         onEndOfPage: () => loadMoreOpini(),
                              //         child:  GridView.builder(
                              //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                              //         scrollDirection: Axis.vertical,
                              //         shrinkWrap: true,
                              //         itemCount: list.length,
                              //         itemBuilder: (BuildContext context, int index) {
                              //           Map cat = list[index];
                              //           print(cat);
                              //           return ListDetail(cat, index);
                              //         },
                              //       ),
                              //       ),

                              //     ],
                              //   ),
                              // );
                        //     }
                        //   } else {
                        //     return Center(child: Text("Loading"));
                        //   }
                        //   //return Center(child: Text("No Image"));
                        // },
                        // future: getOpini())
                    //return Container(child: Text("aa"+idx.toString()));

                    )
          ],
        ));
  }
}
