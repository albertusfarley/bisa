import 'package:flutter/material.dart';
import 'package:bisa/models/loc.dart';
import 'package:bisa/screens/location/location.dart';

class Tile extends StatelessWidget {
  Loc data = Loc();
  Tile(this.data);

  @override
  Widget build(BuildContext context) {
    final String name = data.name;
    final String displayName = data.displayName;
    final String category = data.category;
    final String imageURL = data.imageURL;
    final double tileHeight = 120;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Location(
                      data: data,
                    )));
      },
      child: Container(
        height: tileHeight,
        decoration: BoxDecoration(color: Colors.transparent),
        child: Container(
          margin: EdgeInsets.only(bottom: 40, left: 16, right: 16),
          alignment: Alignment.bottomCenter,
          // decoration: BoxDecoration(color: Colors.yellow),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 108,
                decoration: BoxDecoration(
                    // color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: AssetImage(imageURL), fit: BoxFit.fill)),
              ),
              Container(
                // width: 160,
                margin: EdgeInsets.only(left: 20),
                // decoration: BoxDecoration(color: Colors.red),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        '${displayName}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      padding: EdgeInsets.only(bottom: 4),
                    ),
                    Text(
                      '${category}',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    // Spacer(),
                    // Text(
                    //   '8.2 km',
                    //   style: TextStyle(fontSize: 16),
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
