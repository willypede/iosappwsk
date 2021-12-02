import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        CarouselSlider(
         options: CarouselOptions(
           height: 400.0,
           viewportFraction: 1,
           autoPlay: true,
           autoPlayInterval: Duration(seconds: 2),
         ),
          items: [1, 2, 3, 4, 5].map(
            (i){
            return Builder(
              builder: (BuildContext context){
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.amber),
                  child: Center(
                    child: Text(
                      'text $i',
                      style: TextStyle(fontSize: 16.0),
                    )
                  )
                );
              }
            );
          },
          ).toList(),
        ),
      ],
    );
  }
}