import 'package:flutter/material.dart';
import 'package:iosappwsk/NavBar.dart';
import 'package:url_launcher/url_launcher.dart';

class DukungKami extends StatefulWidget {
  const DukungKami({ Key? key }) : super(key: key);

  @override
  _DukungKamiState createState() => _DukungKamiState();
}

class _DukungKamiState extends State<DukungKami> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: NavBar(),
      appBar: AppBar(
        title: Text("DUKUNG KAMI"),
        backgroundColor: Colors.red,
      ),
      body: new ListView(
        children: <Widget>[
          new Image.asset(
            "assets/dukungkami.jpg",
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                new Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        
                        child: Text(
                          "DUKUNG KAMI",
                          textAlign: TextAlign.center,
                          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.grey[700]),
                        ),
                      ),
                      // kirim@warungsatekamu.org
                    ],
                  )
                  ),

              ],
            )
          ),
          Container(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "WarungSaTeKaMu adalah pelayanan bagi anak muda dari Our Daily Bread Ministries. Sejak berdiri pada tahun 2010, kami berkembang menjadi lebih dari sekedar situs yang tidak hanya menyediakan materi-materi bersaat teduh, tetapi juga sebagai wadah kreatif tempat anak muda membagikan karyanya untuk dinikmati anak muda lainnya.",
              softWrap: true,
              style: TextStyle(color: Colors.grey[600]),
            )
          ),
          Container(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Mungkin sobat muda bertanya, bagaimana WarungSaTeKaMu didanai selama ini?",
              softWrap: true,
              style: TextStyle(color: Colors.grey[600]),
            )
          ),
          Container(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Kami tidak berada di bawah naungan gereja atau denominasi mana pun. Kami bersyukur atas dukungan dari para pembaca yang memberikan persembahan kasih kepada kami hingga kami dapat terus berinovasi mengembangkan pelayanan digital yang relevan bagi anak muda.",
              softWrap: true,
              style: TextStyle(color: Colors.grey[600]),
            )
          ),
       SizedBox(
         height: 20.0,
       ),
       Material(
                          color: Color(0xFF01A0C7),
                            child: MaterialButton(
                              
                              minWidth: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(left:20.0, right: 20.0),
                              onPressed: () async {                                
                              await openUrl('https://santapanrohani.org/donate/indonesia/#payment');
                              },
                              child: Text("DONATE",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
                              ),
                              ),
                          ),
                SizedBox(
         height: 20.0,
       ), 
       Container(
            padding: const EdgeInsets.only(top: 15.0,left:15.0,right: 15.0,),
            child: Text(
              "Agar kami dapat mempertanggungjawabkan persembahan kasih yang kamu berikan dan memberikan tanda terima kepadamu, kirim konfirmasi persembahan kasihmu melalui:",
              softWrap: true,
              style: TextStyle(color: Colors.grey[600]),
            )
          ),
          Container(
            padding: const EdgeInsets.only(left:15.0,right: 15.0,),
            child: Text(
              "WhatsApp: 0878 7878 9978",
              softWrap: true,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )
          ),
          Container(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Doa, daya, dan dukungan dana dari setiap sobat muda memampukan WarungSaTeKaMu hadir, menciptakan, dan menabur konten-konten berlandaskan firman Tuhan di internet.",
              softWrap: true,
              style: TextStyle(color: Colors.grey[600]),
            )
          ),  
         ]
                       
        
      )
    );
  }
}

Future<void> openUrl(String url, {bool forceWebView = false, bool enableJavaScript = false}) async{
  await launch(url);
}