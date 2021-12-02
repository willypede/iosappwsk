import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iosappwsk/Detail.dart';
import 'package:iosappwsk/NavBar.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class RSKPage extends StatefulWidget {
  List? list;
  late int index;

  @override
  _RSKPageState createState() => _RSKPageState();
}

class _RSKPageState extends State<RSKPage> {
  ScrollController? controller;

  void initState() {
    controller = new ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    print(controller!.position.extentAfter);
    if (controller!.position.extentAfter < 500) {
      setState(() {
        //items.addAll(new List.generate(42, (index) => 'Inserted $index'));
      });
    }
  }

  Future<List?> getRSK() async {
    print("before");
    final response = await http.post(
        Uri.parse(
          "https://warungsatekamu.org/wsk_app_2020/loadRSK.php",
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
        },
        child: Column(children: [
          Image.network(data["image"],
              height: 130, width: 300, fit: BoxFit.fill),
          Container(child: Text(data["title"])),
          Container(
            child: Text(
              data["date"],
              style: TextStyle(color: Colors.grey),
            ),
          )
        ]));
  }

  loadMoreRSK() async {
    final response = await http.post(
        Uri.parse(
          "https://warungsatekamu.org/wsk_app_2020/loadRSK.php",
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
      getRSK();
      first = false;
    }
    return LazyLoadScrollView(
      onEndOfPage: () => loadMoreRSK(),
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
      getRSK();
      first = false;
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10.0,
                      ),
                    )
                  ],
                )),
            Expanded(child: getData()
                //        child: Padding(
                //          padding: const EdgeInsets.all(8.0),
                //         child: FutureBuilder(
                //   builder: (context, data) {
                //     if (data.hasData) {
                //       list = data.data as List<dynamic>;
                //       print(list.toString());
                //       if (list.length <= 0) {
                //         return Center(child: Text("Tidak ada saat teduh"));
                //       } else {
                //         print("list");
                //         if (first)
                      //  {
                      //    getRSK();
                      //    first=false;
                      //  }

                //         return LazyLoadScrollView(
                //                 onEndOfPage: () => loadMoreRSK(),
                //                 child:  GridView.builder(
                //                 controller: controller,
                //                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                //                 scrollDirection: Axis.vertical,
                //                 shrinkWrap: true,
                //                 itemCount: list.length,
                //                 itemBuilder: (BuildContext context, int index) {
                //                   Map cat = list[index];
                //                   print(cat);
                //                   return ListDetail(cat, index);
                //                 },
                //               ),
                //               );

                //       }
                //     } else {
                //       return Center(child: Text("Loading"));
                //     }

                //   },
                //   future: getRSK())

                )
          ],
        ));
  }
}
