import 'package:flutter/material.dart';

import '../../page_santapan_rohani.dart';

class MyGridView extends StatelessWidget {
  MyGridView(this.data);
  final data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () async {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SantapanRohaniPage(data)));
        },
        child: Card(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image.network(data["image"], fit: BoxFit.cover),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data["title"],
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        softWrap: true,
                        style: TextStyle(
                            fontSize: 12
                        ),
                      ),
                      Text(data["date"],
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ]
          ),
        ),
      ),
    );
  }
}
