import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iosappwsk/NavBar.dart';
import 'package:iosappwsk/page_santapan_rohani.dart';
import 'Detail.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class HomeScreen extends StatefulWidget {
  late int index;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List imgList = [];
  List? list;

  List<Tab> _tabList = [
    Tab(
      child: Text("SAAT TEDUH"),
    ),
    Tab(
      child: Text("ARTIKEL"),
    ),
  ];

  TabController? _tabController;
  TabController? _tabController2;
  int _selectedIndex = -1;

  @override
  ScrollController? controller;

  void initState() {
    super.initState();
    getSate();
    controller = new ScrollController()..addListener(_scrollListener);
    _tabController = TabController(vsync: this, length: _tabList.length);

    _tabController!.addListener(() {
      setState(() {
        _selectedIndex = _tabController!.index;
      });
    });
    getGambar();
  }

  void _scrollListener() {
    // print(controller!.position.extentAfter);
    if (controller!.position.extentAfter < 500) {
      setState(() {
        //items.addAll(new List.generate(42, (index) => 'Inserted $index'));
      });
    }
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  Widget getContentTab() {
    return Container(child: Text("aa" + _selectedIndex.toString()));
  }

  Future<List?> getSate() async {
    list = [];
    print("before");
    final response = await http.post(
        Uri.parse(
          "https://warungsatekamu.org/wsk_app_2020/loadSate.php",
        ),
        body: {"limit": "0"});
    //print("hasil "+response.body.toString());
    var data = json.decode(response.body);
    list = data;
    setState(() {});
  }

  Future<List?> getGambar() async {
    print("before");
    final response = await http.post(
        Uri.parse(
          "https://www.warungsatekamu.org/wsk_app_2020/loadViewpager.php",
        ),
        body: {});
    //print("hasil "+response.body.toString());
    var data = json.decode(response.body);
    imgList = data;
    setState(() {});
  }

  Future<List?> getArtikel() async {
    print("before");
    final response = await http.post(
        Uri.parse(
          "https://warungsatekamu.org/wsk_app_2020/loadArtikel.php",
        ),
        body: {"limit": "0"});
    //print("hasil "+response.body.toString());
    var data = json.decode(response.body);
    return data;
  }

  var list2 = [];

  Widget ListDetail(Map data, int index) {
    return InkWell(
        onTap: () async {
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => Detail(data)));

          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SantapanRohaniPage(data)));
        },
        child: Column(children: [
          Image.network(data["image"],
              height: 130, width: 250, fit: BoxFit.fill),
          Container(
              child: Text(
            data["title"],
            textAlign: TextAlign.left,
          )),
          Container(
            child: Text(data["date"], style: TextStyle(color: Colors.grey)),
          )
        ]));
  }

  loadMoreSaTe() async {
    final response = await http.post(
        Uri.parse(
          "https://warungsatekamu.org/wsk_app_2020/loadSate.php",
        ),
        body: {"limit": "0"});
    print("hasil sate before " + list!.length.toString());
    list = [];
    var data = json.decode(response.body);
    print("data add " + data.length.toString());
    for (var i = 0; i < data.length; i++) {
      list!.add(data[i]);
    }
    print("hasil sate after " + list!.length.toString());

    setState(() {});
    //print("Load More");
  }

  loadMoreArtikel() async {
    final response = await http.post(
        Uri.parse(
          "https://warungsatekamu.org/wsk_app_2020/loadArtikel.php",
        ),
        body: {"limit": "10"});
    //print("hasil "+response.body.toString());
    var data = json.decode(response.body);
    for (var i = 0; i < data.length; i++) {
      list!.add(data[i]);
    }
    setState(() {
      //getTabData
    });
    //print("Load More");
  }

  bool first = true;

  //int idxBefore=-1;
  Widget getTabData(int idx, BuildContext ctx) {
    if (idx == 0) {
      // print("idx before "+idxBefore.toString()+", idx check "+idx.toString());
      if (first) {
        //getSate();
        first = false;
      }
      //#idxBefore=0;
      return LazyLoadScrollView(
          onEndOfPage: () => loadMoreSaTe(),
          child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            controller: controller,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: list!.length,
            itemBuilder: (BuildContext context, int index) {
              Map cat = list![index];
              // print(cat);
              return ListDetail(cat, index);
            },
          ));
      /*
       return FutureBuilder(
        builder: (context, data) {
          if (data.hasData) {
            list = data.data as List<dynamic>;
            //print(list.toString());
            if (list.length <= 0) {
              return Center(child: Text("Tidak ada saat teduh"));
            } else {
              print("list "+list.length.toString());
              return    LazyLoadScrollView(
                      onEndOfPage: () => loadMoreSaTe(),
                      child:  GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      controller: controller,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map cat = list[index];
                       // print(cat);
                        return ListDetail(cat, index);
                      },
                    ));

            }
          } else {
            return Center(child: Text("Loading"));
          }
        },
        future: getSate());*/
    } else {
      //print("in here ");
      //RidxBefore=1;
      return FutureBuilder(
          builder: (context, data) {
            if (data.hasData) {
              list2 = data.data as List<dynamic>;
              //print(list.toString());
              if (list2.length <= 0) {
                return Center(child: Text("Tidak ada saat teduh"));
              } else {
                //print("list");
                return LazyLoadScrollView(
                  onEndOfPage: () => loadMoreArtikel(),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    controller: controller,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: list2.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map cat = list2[index];
                      //print(cat);
                      return ListDetail(cat, index);
                    },
                  ),
                );
                //print(list);
                //return Center(child: Text("Ada isi"));
                // return SingleChildScrollView(
                //   child: Column(

                //     children: [
                //        LazyLoadScrollView(
                //         onEndOfPage: () => loadMoreArtikel(),
                //         child:  GridView.builder(
                //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                //         controller: controller,
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
              }
            } else {
              return Center(child: Text("Loading"));
            }
          },
          future: getArtikel());
    }
  }

  Widget test() {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: TabBar(
              padding: EdgeInsets.all(8.0),
              // onTap: () {},
              isScrollable: true,
              tabs: <Widget>[
                DefaultTextStyle(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                    child: Tab(text: 'SAAT TEDUH')),
                DefaultTextStyle(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                    child: Tab(text: 'ARTIKEL'))
              ],
              // tabs: [
              //   Tab(text: 'Main Course'),
              //   Tab(text: 'Side Dish'),
              //   Tab(text: 'Drink'),
              //   Tab(text: 'Etc'),
              // ],
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.blueAccent
              // indicator: BubbleTabIndicator(
              //   indicatorHeight: 25.0,
              //   indicatorColor: Colors.blueAccent,
              //   tabBarIndicatorSize: TabBarIndicatorSize.label,
              //   // Other flags
              //   // indicatorRadius: 1,
              //   // insets: EdgeInsets.all(1),
              //   // padding: EdgeInsets.all(10),
              // ),
              ),
          body: Container(
              child: TabBarView(
            children: [
              getTabData(0, context),
              getTabData(1, context)
              // Icon(Icons.directions_bike),
            ],
          ))),
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
          "WarungSaTeKaMu",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
                width: double.infinity,
                child: CarouselSlider(
                  options: CarouselOptions(),
                  items: imgList
                      .map((item) => InkWell(
                          onTap: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Detail(item)));
                            //print("click "+data.toString());
                          },
                          child: Container(
                              width: double.infinity,
                              child: Stack(
                                children: <Widget>[
                                  Center(
                                      child: Image.network(item["image"],
                                          fit: BoxFit.cover,
                                          width: double.infinity)),
                                  Center(
                                    child: Text(item["title"],
                                        style: TextStyle(color: Colors.white)),
                                  )
                                ],
                              ))))
                      .toList(),
                )),
            Expanded(child: test())
          ],
        ),
      ),
    );
  }
}
