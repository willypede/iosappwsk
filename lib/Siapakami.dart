import 'package:flutter/material.dart';
import 'package:iosappwsk/NavBar.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class SiapaKami extends StatefulWidget {
  const SiapaKami({Key? key}) : super(key: key);

  @override
  _SiapaKamiState createState() => _SiapaKamiState();
}

class _SiapaKamiState extends State<SiapaKami> {
  
  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: NavBar(),
        appBar: AppBar(
          title: Text("SIAPA KAMI"),
          backgroundColor: Colors.red,
        ),
        body: new ListView(children: <Widget>[
          new Image.asset(
            "assets/siapakami.jpg",
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
                    ],
                  )),
                ],
              )),
          Container(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Sebuah perjalanan tidak akan pernah terwujud tanpa satu langkah pertama. Pada tahun 2010, langkah pertama itu dimulai. Berangkat dari kerinduan untuk menjangkau kaum muda dengan hikmat alkitab yang mengubahkan kehidupan, Our Daily Bread Ministries di Indonesia menggagas situs WarungSaTeKaMu.org (Warung Saat Teduh Kaum Muda).",
                softWrap: true,
                style: TextStyle(color: Colors.grey[600]),
              )),
          Container(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Dalam perjalanannya, situs ini berkembang menjadi lebih dari sekedar situs yang tidak hanya hadir sebagai penyedia materi-materi bersaat teduh, tetapi juga sebagai wadah kreatif tempat kaum muda membagikan karyanya untuk dinikmati kaum muda lainnya. Karya-karya itu bisa berupa cerita sederhana, lagu, puisi ataupun gambar. Kami percaya bahwa satu karya sederhana bisa dipakai Tuhan untuk menginspirasi banyak orang.",
                softWrap: true,
                style: TextStyle(color: Colors.grey[600]),
              )),
          Container(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Pelayanan ini bukanlah tentang kami sendiri, tetapi tentang bagaimana Tuhan berkarya bagi kaum muda Indonesia melalui ranah digital. Pelayanan kami didukung oleh raturan kontributor yang tekun dan setia mengirimkan karya-karyanya kepada kami sampai dengan hari ini.",
                softWrap: true,
                style: TextStyle(color: Colors.grey[600]),
              )),
          Container(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Teruntuk kamu yang sekarang sedang membaca halaman ini, kami mengucapkan selamat datang dan selamat bergabung dengan WarungSaTeKaMu. Kiranya beragam materi di situs ini boleh menginspirasimu dan mendukungmu untuk terus bertumbuh di dalam Tuhan Yesus Kristus.",
                softWrap: true,
                style: TextStyle(color: Colors.grey[600]),
              )),
          Container(
            width: 500.0,
            height: 42.0,
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                'HUBUNGI KAMI',
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
                "Nama",
              ),
              height: 30.0,
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                controller: _name,
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
              child: Text("E-Mail"),
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
              child: Text("Kritik dan Saran"),
              height: 30.0,
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                controller: _message,
                maxLines: 8,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Kritik dan saran",
                ),
              )),
          SizedBox(
            height: 20.0,
          ),
          Material(
            color: Color(0xFF01A0C7),
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              // onPressed:() async {
              //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => SKSecond(email: _email.text,name: _name.text,message: _message.text,)));

              // },
              // onPressed:() async{
              // await sendEmail('kirim@warungsatekamu.org', 'Kritik dan Saran',  'Nama: \n' + _name.text + '\n||\n'+ '\nEmail:' + _email.text + '\n||\n' +'Kritik dan Saran:\n' + _message.text );
              // },
              onPressed: (){sendEmail();},
              // onPressed:() => Utils.openEmail(
              //   toEmail: _email.text,
              //   subject: _name.text, 
              //   body: _message.text,
              //   ),
                // onPressed:() => sendEmail(
                // email: 'ryantejawijaya77@gmail.com',
                // name: 'subject', 
                // message: 'asaas',
                // ),
              child: Text(
                "Kirim",
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
// Future<void> openEmail(String email) async{
//   await launch('mailto:$email');
// }

// Future<void> sendEmail(String email, String subject, String body) async{
//   await launch('mailto:$email?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(body)}');
// }

// Future sendEmail({
//   required String name,
//   required String email,
//   required String message,
// }) async {
//   final serviceId = 'service_q7nuqoo';
//   final templateId = 'template_7mkaeds';
//   final userId = 'user_iauRLF9UOJD1Lpi5qZT8A';

//   final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
//   final response = await http.post(
//     url,
//     headers: {
//       'origin': 'http://localhost',
//       'Content-Type': 'application/json',
//     },
//     body: json.encode({
//       'service_id': serviceId,
//       'template_id': templateId,
//       'user_id': userId,
//       'template_params': {
//         'user_name': name,
//         'user_email': email,
//         'user_message': message,
//       }
//     }),
//   );
//   print(response.body);
// }

// Future openEmail({
//     required String toEmail, 
//     required String subject, 
//     required String body,
//     }) async {
//       final url = 'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(body)}';

//       if(await canLaunch(url)){
//       await launch(url);
//       }
//     }

 sendEmail() async {
  String username = 'ryantejawijaya@gmail.com';
  String password = 'Ry1234567';
  String domainSmtp = 'mail.google.com';

//  final smtpServer = gmail(username, password);

 final smtpServer = SmtpServer(domainSmtp, username: username, password: password, port: 587);
  // Use the SmtpServer class to configure an SMTP server:
  // final smtpServer = SmtpServer('smtp.domain.com');
  // See the named arguments of SmtpServer for further configuration
  // options.  

  // Create our message.
  final message = Message()
    ..from = Address(username, 'Your name')
    ..recipients.add('ryantejawijaya77@gmail.com')
    // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
    // ..bccRecipients.add(Address('bccAddress@example.com'))
    ..subject = 'Kritik dan Saran :: 😀 :: ${DateTime.now()}'
    ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html = "<h1>Hello</h1>\n<p>Hello</p>";

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
   
 
}   