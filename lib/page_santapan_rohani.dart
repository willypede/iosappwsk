import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:http/http.dart' as http;
import 'package:iosappwsk/model/santapan_rohani_content.dart';
import 'package:iosappwsk/services/indonesian_calendar.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:iosappwsk/model/comment.dart' as cmt;

class SantapanRohaniPage extends StatefulWidget {
  SantapanRohaniPage(this.data);
  final data;

  @override
  State<SantapanRohaniPage> createState() => _SantapanRohaniPageState();
}

class _SantapanRohaniPageState extends State<SantapanRohaniPage> {
  List<cmt.Comment> arrComment = [];
  late var id;
  SantapanRohaniContent src = SantapanRohaniContent(
      date: "", title: "", content: "", excerpt: "",
      image: "", guid: "");

  Future<void> _fetchSantapanRohaniContent(String id) async{
    final Map<String, String> data = ({
      'id': id,
    });
    final response = await http.post(
        Uri.parse("https://warungsatekamu.org/wsk_app_2020/loadContent.php"),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept': '*/*',
        },
        body: data);

    if(response.statusCode == 200){
      final jsonData = json.decode(response.body);
      final date = jsonData["date"];
      final title = jsonData["title"];
      final content = jsonData["content"];
      final excerpt = jsonData["excerpt"];
      final image = jsonData["image"];
      final guid = jsonData["guid"];

      final santapanRohanicContent = SantapanRohaniContent(
          date: date, title: title, content: content, excerpt: excerpt,
          image: image, guid: guid);
      src = santapanRohanicContent;
    }
  }
  Future<void> _fetchComment(String id) async{
    final Map<String, String> data = ({
      'id': id,
    });
    final response = await http.post(
        Uri.parse("https://warungsatekamu.org/wsk_app_2020/loadComments.php"),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept': '*/*',
        },
        body: data);

    if(response.statusCode == 200){
      arrComment.clear();
      final jsonData = json.decode(response.body);
      for(var data in jsonData){
        final name = data["name"];
        final imageUrl = data["image_url"];
        final comment = data["comment"];
        final date = data["date"];
        final cmt.Comment commentData = cmt.Comment(
          name: name,
          date: date,
          comment: comment,
          imageUrl: imageUrl
        );
        arrComment.add(commentData);
      }
    }
  }
  void setup() async {
    id = widget.data["id"];
    await _fetchSantapanRohaniContent(id);
    await _fetchComment(id);
    setState(() {

    });
  }
  @override
  void initState() {
    setup();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final myCommentController = TextEditingController();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Text(
                "WarungSaTeKaMu"
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 24,
              ),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: Image(
                    image: NetworkImage(
                        widget.data["image"]
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        src.title,
                        style: TextStyle(
                            fontFamily: "Lato",
                            fontSize: 28,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w700
                        ),
                      ),
                      Text(
                        src.date,
                        style: TextStyle(
                            fontFamily: "Lato",
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                      Html(
                        data: src.content,
                        style: {
                          "table": Style(
                            backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                          ),
                          "tr": Style(
                            border: Border(bottom: BorderSide(color: Colors.grey)),
                          ),
                          "th": Style(
                            padding: EdgeInsets.all(6),
                            backgroundColor: Colors.grey,
                          ),
                          "td": Style(
                            padding: EdgeInsets.all(6),
                            alignment: Alignment.topLeft,
                          ),
                          'h5': Style(maxLines: 2, textOverflow: TextOverflow.ellipsis),
                        },
                        customRender: {
                          "table": (context, child) {
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child:
                              (context.tree as TableLayoutElement).toWidget(context),
                            );
                          },
                        },
                        onLinkTap: (url, _, __, ___) {
                          print("Opening $url...");
                        },
                        onImageTap: (src, _, __, ___) {
                          print(src);
                        },
                        onImageError: (exception, stackTrace) {
                          print(exception);
                        },
                        onCssParseError: (css, messages) {
                          print("css that errored: $css");
                          print("error messages:");
                          messages.forEach((element) {
                            print(element);
                          });
                        },
                      ),

                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      color: Colors.blue,
                      child: Row(
                        children: [
                          Icon(PhosphorIcons.chatText,
                            size: 32,
                            color: Colors.white,),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "KOMENTAR",
                            style: TextStyle(
                                fontFamily: "Lato",
                                fontSize: 18,
                                color: Colors.white
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: 32,
                                  height: 32,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.transparent,
                                      ),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-High-Quality-Image.png"))
                                  )),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      "Dummy",
                                      style: TextStyle(
                                          fontFamily: "Lato",
                                          fontWeight: FontWeight.bold,
                                          color: Colors.cyan
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),

                                    TextField(
                                      keyboardType: TextInputType.multiline,
                                      controller: myCommentController,
                                      maxLines: 3,
                                      minLines: 3,
                                      decoration: InputDecoration(
                                          alignLabelWithHint: true,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              )),
                                          contentPadding: EdgeInsets.all(8),
                                          labelText: "Tuliskan komentarmu disini...",
                                          labelStyle: TextStyle(
                                              fontFamily: "Nunito", color: Colors.grey)),
                                      style: const TextStyle(
                                          fontFamily: "Nunito",
                                      fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    ElevatedButton(
                                        onPressed: (){
                                          // comment
                                        },
                                        child: Text(
                                            "KIRIM"
                                        ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Colors.grey,
                        )
                      ],
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    ListView.builder(
                      reverse: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: arrComment.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      width: 32,
                                      height: 32,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.transparent,
                                          ),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  arrComment[index].imageUrl != "" || arrComment[index].imageUrl == null
                                                      ? arrComment[index].imageUrl :
                                                  "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-High-Quality-Image.png"))
                                      )),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              arrComment[index].name,
                                              style: TextStyle(
                                                  fontFamily: "Lato",
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.cyan
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              arrComment[index].date,
                                              style: TextStyle(
                                                  fontFamily: "Lato",
                                                  fontSize: 12
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          arrComment[index].comment,
                                          style: TextStyle(
                                              fontFamily: "Lato",
                                              color: Colors.grey[600],
                                              fontWeight: FontWeight.normal
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 1,
                              color: Colors.grey,
                            )
                          ],
                        );
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
