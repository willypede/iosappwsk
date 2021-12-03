import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iosappwsk/Lock.dart';
import 'package:iosappwsk/NavBar.dart';
import 'package:iosappwsk/pages/home_screen/grid_view.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class LockScreenPage extends StatefulWidget {
  List? list;
  late int index;

  @override
  _LockScreenPageState createState() => _LockScreenPageState();
}

class _LockScreenPageState extends State<LockScreenPage> {
  ScrollController? controller;
  String banner = "";
  String judul = "";

  void initState() {
    controller = new ScrollController()..addListener(_scrollListener);
    _fetchBannerData();
    super.initState();
  }

  Future<void> _fetchBannerData() async {
    final response = await http.get(
        Uri.parse("https://warungsatekamu.org/wsk_app_2020/load1Lockscreen.php"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });
    if(response.statusCode == 200){
      final jsonDataArray = json.decode(response.body);
      final jsonData = jsonDataArray[0];
      final image = jsonData["image"].toString().replaceAll("\\", "");
      final title = jsonData["title"];
      banner = image;
      judul = title;
      setState(() {
        print("banner: " + banner);
      });
    }
  }
  void _scrollListener() {
    print(controller!.position.extentAfter);
    if (controller!.position.extentAfter < 500) {
      setState(() {
        //items.addAll(new List.generate(42, (index) => 'Inserted $index'));
      });
    }
  }

  Future<List?> getLock() async {
    print("before");
    final response = await http.post(
        Uri.parse(
          "https://warungsatekamu.org/wsk_app_2020/loadLockscreen.php",
        ),
        body: {"limit": "0"});
    print("hasil " + response.body.toString());
    var data = json.decode(response.body);
    return data;
  }

  var list = [];

  Widget ListDetail(Map data, int index) {
    return InkWell(
        onTap: () async {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Lock(data)));
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

  loadMoreLock() async {
    final response = await http.post(
        Uri.parse(
          "https://warungsatekamu.org/wsk_app_2020/loadLockscreen.php",
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

  @override
  bool first = true;

  Widget build(BuildContext context) {
    if (first) {
      getLock();
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
            banner != "" ? Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: Image.network(banner,
                          fit: BoxFit.fill,
                          width: double.infinity)),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    Center(
                        child: Container(
                          color: Colors.blue,
                          padding: EdgeInsets.all(4),
                          child: Text(
                            "RUANG SENI KAMU",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Lato",
                              color: Colors.white,
                            ),
                          ),
                        )
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        judul,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Lato",
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                    )
                  ],
                )
              ],
            ) : Container(),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder(
                        builder: (context, data) {
                          if (data.hasData) {
                            list = data.data as List<dynamic>;
                            print(list.toString());
                            if (list.length <= 0) {
                              return Center(
                                  child: Text("Tidak ada saat teduh"));
                            } else {
                              print("list");

                              if (first) {
                                getLock();
                                first = false;
                              }

                              return LazyLoadScrollView(
                                onEndOfPage: () => loadMoreLock(),
                                child: GridView.builder(
                                  controller: controller,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: list.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Map cat = list[index];
                                    print(cat);
                                    return MyGridView(cat);
                                  },
                                ),
                              );
                            }
                          } else {
                            return Center(child: Text("Loading"));
                          }
                        },
                        future: getLock())))
          ],
        ));
  }
}
