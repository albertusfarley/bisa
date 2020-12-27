import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bisa/models/loc.dart';
import 'package:bisa/services/database.dart';
import 'package:provider/provider.dart';
import 'lot.dart';

class Location extends StatefulWidget {
  final Loc data;
  Location({this.data});

  @override
  _LocationState createState() => _LocationState(data: data);
}

class _LocationState extends State<Location> {
  final Loc data;
  _LocationState({this.data});

  @override
  Widget build(BuildContext context) {
    final String name = data.name;
    final String displayName = data.displayName;

    return StreamProvider<DocumentSnapshot>.value(
      value: DatabaseService().placement,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Stack(
            children: [
              Lot(name: name),
              Container(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 88,
                    width: double.infinity,
                    color: Colors.white,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        padding: EdgeInsets.only(bottom: 16, left: 32),
                        child: Text(
                          displayName,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
