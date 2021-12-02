import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:iosappwsk/NavBar.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class KirimKarya extends StatefulWidget {
  const KirimKarya({Key? key}) : super(key: key);

  @override
  _KirimKaryaState createState() => _KirimKaryaState();
}

class _KirimKaryaState extends State<KirimKarya> {
  final TextEditingController _nama = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _umur = TextEditingController();
  final TextEditingController _kota = TextEditingController();
  final TextEditingController _tentangkamu = TextEditingController();
  final TextEditingController _judulkiriman = TextEditingController();
  final TextEditingController _isikiriman = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var file;

    return Scaffold(
        backgroundColor: Colors.white,
        drawer: NavBar(),
        appBar: AppBar(
          title: Text("KIRIM KARYA"),
          backgroundColor: Colors.red,
        ),
        body: new ListView(children: <Widget>[
          new Image.asset(
            "assets/kirimkarya.jpg",
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
                          "SIAPA KAMI",
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.grey[700]),
                        ),
                      ),
                      //https://santapanrohani.org/donate/indonesia/#payment
                    ],
                  )),
                ],
              )),
          Container(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Kami mengajakmu untuk berkontribusi di WarungSaTeKaMu dengan mengirimkan karyamu kepada kami untuk dimuat dalam situs ini dan menjadi berkat bagi banyak anak muda.",
                softWrap: true,
                style: TextStyle(color: Colors.grey[600]),
              )),
          Container(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Berikut adalah syarat dari kontribusi yang akan kami terbitkan:",
                softWrap: true,
                style: TextStyle(color: Colors.grey[600]),
              )),
          Container(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "1. Karya orisinal. Semua kontribusi yang dikirimkan harus merupakan karya pengirim sendiri. Kami menerima kiriman artikel yang sudah pernah dikirimkan atau dimuat di media lain, namun perlu diingat bahwa semua kontribusi yang masuk akan melewati proses penyuntingan sebelum dimuat di situs web kami.",
                softWrap: true,
                style: TextStyle(color: Colors.grey[600]),
              )),
          Container(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "2. Personal dan relasional. Tulisan harus mengaitkan kebenaran Alkitab dengan pengalaman penulis. Ditulis dengan sudut pandang orang pertama (aku) atau ketiga (kita). Mengangkat isu-isu yang dihadapi kaum muda dalam konteks lokal.",
                softWrap: true,
                style: TextStyle(color: Colors.grey[600], fontFamily: 'Roboto'),
              )),
          Container(
            width: 500.0,
            height: 42.0,
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                'Kirim Karya',
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
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: SizedBox(
              child: Text(
                "Nama :",
              ),
              height: 30.0,
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                controller: _nama,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nama",
                ),
              )),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: SizedBox(
              child: Text("E-Mail :"),
              height: 30.0,
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                controller: _email,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "E-Mail",
                ),
              )),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: SizedBox(
              child: Text("Umur :"),
              height: 30.0,
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                controller: _umur,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Umur",
                ),
              )),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: SizedBox(
              child: Text(
                "Kota:",
              ),
              height: 30.0,
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                controller: _kota,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Kota",
                ),
              )),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: SizedBox(
              child: Text(
                "Tentang Kamu :",
              ),
              height: 30.0,
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                controller: _tentangkamu,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Tentang Kamu",
                ),
              )),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: SizedBox(
              child: Text(
                "Judul Kiriman :",
              ),
              height: 30.0,
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                controller: _judulkiriman,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Judul Kiriman",
                ),
              )),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: SizedBox(
              child: Text(
                "Isi Kiriman :",
              ),
              height: 30.0,
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                controller: _isikiriman,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Isi Kiriman",
                ),
              )),
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: SizedBox(
                  child: Text(
                    "Lampiran",
                  ),
                  height: 30.0,
                ),
              ),
              SizedBox(
                width: 200.0,
              ),
              ElevatedButton(
                  onPressed: () async {
                    final result = await FilePicker.platform.pickFiles();
                    if (result == null) return;
                    final file = result.files.first;
                    //  openFile(file);
                    // print('Name: ${file.name}');
                    // print('Bytes: ${file.bytes}');
                    // print('Size: ${file.size}');
                    // print('Extension: ${file.name}');
                    // print('Path: ${file.path}');

                    final newFile = await saveFilePermanently(file);

                    print('From Path: ${file.path!}');
                    print('To Path: ${newFile.path}');

                    // await saveFilePermanently(file);
                  },
                  child: Text("Pick File"))
            ],
          ),
          Material(
            color: Color(0xFF01A0C7),
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              onPressed: () async {
                var newFile;
                await sendEmail(
                    'kirim@warungsatekamu.org',
                    'Kirim Karya',
                    'Nama:\n' +
                        _nama.text +
                        '\n||\n' +
                        'Email:\n' +
                        _email.text +
                        '\n||\n' +
                        'Kota:\n' +
                        _kota.text +
                        '\n||\n' +
                        'Umur:\n' +
                        _umur.text +
                        '\n||\n' +
                        'Tentang Kamu:\n' +
                        _tentangkamu.text +
                        '\n||\n' +
                        'Judul Kiriman:\n' +
                        _judulkiriman.text +
                        '\n||\n' +
                        'Isi Kiriman:\n' +
                        _isikiriman.text);
              },
              child: Text(
                "Kirim Karya",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
        ]));
  }
}
// Future<File> saveFilePermanently(PlatformFile file) async{
//   final appStorage = await getApplicationDocumentsDirectory();
//   final newFile = File('${appStorage.path}/${file.name}');

//   return File(file.path!).copy(newFile.path);
// }
Future<File> saveFilePermanently(PlatformFile file) async {
  final appStorage = await getApplicationDocumentsDirectory();
  final newFile = File('${appStorage.path}/${file.name}');

  return File(file.path!).copy(newFile.path);
}

void openFile(PlatformFile file) {
  OpenFile.open(file.path!);
}

Future<void> sendEmail(String email, String subject, String body) async {
  await launch(
      'mailto:$email?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(body)}');
}
