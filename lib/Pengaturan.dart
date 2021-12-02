
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';


class Reminder extends StatefulWidget {
  

  @override
  _ReminderState createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {

  // @override 
  // void initState(){
    
  //   Timer.periodic(Duration(seconds: 1), (timer){
      
  //     setState(() {
        
  //     });
      
  //   });
    
  //   super.initState();
  // }

  void printGoodbye() {
     print("test 124");
    //printHelloMessage("Goodbye, world!");
  }
  bool isSwitched=true;
  @override
  Widget build(BuildContext context) {
    return 
    Container(
       alignment: Alignment.centerLeft,
      child: Column(
          children: <Widget>[
            Container(
              child:Text(
                "Reminder",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600, // insert your font size here
                  )
                ),
            ),
            Row(
              children: [
                Switch(
                  value: isSwitched,
                  onChanged: (value) async {
                    if (value)
                    {
                        await AndroidAlarmManager.oneShot(
                            const Duration(seconds: 60),
                            // Ensure we have a unique alarm ID.
                            Random().nextInt(pow(2, 31).toInt()),
                            printGoodbye,
                            exact: true,
                            wakeup: true,
                            alarmClock: true
                          );
                        print("abc");
                    }
                    setState(()  {
                      isSwitched = value;
                      if (isSwitched)
                      {
                        _selectTime(context);
                      
                      }
                      print(isSwitched);
                    });
                  },
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.green,
                )
                ,
                    Text("${selectedTime.hour}:${selectedTime.minute}")

              ],
            ),
            
          ],
        )
    );
    
  }

  TimeOfDay selectedTime = TimeOfDay.now();
  _selectTime(BuildContext context) async {
        final TimeOfDay? timeOfDay = await showTimePicker(
          context: context,
          initialTime: selectedTime,
          initialEntryMode: TimePickerEntryMode.dial,
  
        );
        if(timeOfDay != null && timeOfDay != selectedTime)
          {
            setState(() {
              selectedTime = timeOfDay;
            });
          }
    }
}


class ClockPainter extends CustomPainter
{
  var dateTime = DateTime.now();
  @override
  void paint(Canvas canvas, Size size){
    var centerX = size.width/2;
    var centerY = size.height/2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var fillBrush = Paint()
    ..color = Color(0xFF444974);

     var outlineBrush = Paint()
    ..color = Color(0xFFEAECFF)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 16;

     var centerFillBrush = Paint()
    ..color = Color(0xFFEAECFF);

    var dashBrush = Paint()
    ..color = Color(0xFFEAECFF)
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 2;

    var secHandBrush = Paint()
    ..color = Colors.orange
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 16;

    var minHandBrush = Paint()
    ..shader = RadialGradient(colors:[Colors.lightBlue, Colors.pink]).createShader(Rect.fromCircle(center:center, radius: radius))
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 16;

    var hourHandBrush = Paint()
    ..shader = RadialGradient(colors:[Colors.lightBlue, Colors.pink]).createShader(Rect.fromCircle(center:center, radius: radius))
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 16;

    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 40, outlineBrush);

    var secHandX = centerX + 80 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centerX + 80 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX,secHandY), secHandBrush);

    var minHandX = centerX + 80 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY = centerX + 80 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX,minHandY), minHandBrush);

    var hourHandX = centerX + 60 * cos((dateTime.hour * 30 + dateTime.minute * 0.5 )* pi / 180);
    var hourHandY = centerX + 60 * sin((dateTime.hour * 30 + dateTime.minute * 0.5 )* pi / 180);
    canvas.drawLine(center, Offset(hourHandX,hourHandY), hourHandBrush);

    canvas.drawCircle(center, 16, centerFillBrush);
    
    var outerCircleRadius = radius;
    var innerCircleRadius = radius - 14;
    for (double i = 0; i < 360; i += 12){
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outerCircleRadius * sin(i * pi / 180);

      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerX + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);

    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate){
    return true;
  }
}