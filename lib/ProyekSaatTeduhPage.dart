
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iosappwsk/Detail.dart';
import 'package:iosappwsk/NavBar.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class PSTPage extends StatefulWidget {
  List? list;
  late int index;

  @override
  _PSTPageState createState() => _PSTPageState();
}

class _PSTPageState extends State<PSTPage> {
  ScrollController? controller;

 List imgList = [];
  Future<List?> getGambar() async {
  print("before");
  final response = await http.post(Uri.parse("https://www.warungsatekamu.org/wsk_app_2020/load1PST.php",
  ), body: {
  });
  //print("hasil "+response.body.toString());
  var data = json.decode(response.body);
  imgList=data;
  setState(() {
    
  });
  }
  void initState() {
    controller = new ScrollController()..addListener(_scrollListener);
    super.initState();
    getGambar();
  }

  void _scrollListener() {
    print(controller!.position.extentAfter);
    if (controller!.position.extentAfter < 500) {
      setState(() {
        //items.addAll(new List.generate(42, (index) => 'Inserted $index'));
      });
    }
  }

  Future<List?> getPST() async {
    print("before");
    final response = await http.post(
        Uri.parse(
          "https://warungsatekamu.org/wsk_app_2020/loadPST.php",
        ),
        body: {"limit": "0"});
    print("hasil " + response.body.toString());
    var data = json.decode(response.body);
    list = data;
    setState(() {});
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

  loadMorePST() async {
    final response = await http.post(
        Uri.parse(
          "https://warungsatekamu.org/wsk_app_2020/loadPST.php",
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

  Widget getData() {
    if (first) {
      getPST();
      first = false;
    }
    return LazyLoadScrollView(
      onEndOfPage: () => loadMorePST(),
      child: GridView.builder(
        controller: controller,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
    if (first) {
      getPST();
      first = false;
    }
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
           
            Expanded(child: getData()
                //       child: Padding(
                //        padding: const EdgeInsets.all(8.0),
                //       child: FutureBuilder(
                // builder: (context, data) {
                //   if (data.hasData) {
                //     list = data.data as List<dynamic>;
                //     print(list.toString());
                //     if (list.length <= 0) {
                //       return Center(child: Text("Tidak ada saat teduh"));
                //     } else {
                //       print("list");
                //       return LazyLoadScrollView(
                //               onEndOfPage: () => loadMorePST(),
                //               child:  GridView.builder(
                //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                //               scrollDirection: Axis.vertical,
                //               shrinkWrap: true,
                //               itemCount: list.length,
                //               itemBuilder: (BuildContext context, int index) {
                //                 Map cat = list[index];
                //                 print(cat);
                //                 return ListDetail(cat, index);
                //               },
                //             ),
                //             );
                // return SingleChildScrollView(
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //        LazyLoadScrollView(
                //         onEndOfPage: () => loadMorePST(),
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

                //   } else {
                //     return Center(child: Text("Loading"));
                //   }
                //   //return Center(child: Text("No Image"));
                // },
                // future: getPST())
                //return Container(child: Text("aa"+idx.toString()));

                )
          ],
        ));
  }
}
