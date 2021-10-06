import 'package:bisa/models/user.dart';
import 'package:bisa/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:bisa/screens/home/gmap.dart';
import 'package:bisa/services/database.dart';
import 'location_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  final PanelController _pc = PanelController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    final double panelMinHeight = 40;
    final double panelMaxHeight = 200;

    final double panelListTileHeight = panelMaxHeight - panelMinHeight - 40;

    return StreamProvider<DocumentSnapshot>.value(
      value: DatabaseService().geopoint,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SlidingUpPanel(
          defaultPanelState: PanelState.CLOSED,
          onPanelClosed: () {
            setState(() {
              print('-------------------------- 1337 kondisi panel ditutup');
            });
          },
          controller: _pc,
          minHeight: panelMinHeight,
          maxHeight: panelMaxHeight,
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: Colors.transparent,
            ),
          ],
          panel: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    print('321 Bar Tapped');
                    if (_pc.isPanelClosed)
                      _pc.open();
                    else
                      _pc.close();
                  },
                  child: Container(
                    height: panelMinHeight,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 4,
                        width: 64,
                        margin: EdgeInsets.only(
                            left: 16, bottom: 12, top: 24, right: 16),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                    
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16, top: 12, bottom: 4),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Our Suggestion for You...',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Container(
                  height: panelListTileHeight,
                  child: StreamProvider.value(
                      value: DatabaseService().location, child: LocationList()),
                )
              ],
            ),
          ),
          body: Stack(
            children: [
              Consumer<Position>(
                builder: (context, position, widget) {
                  return (position != null)
                      ? Gmap(position)
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 48, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${user.displayName}',
                    ),
                    Text('   '),
                    GestureDetector(
                      onTap: () => _auth.signOut(),
                      child: CircleAvatar(
                        radius: 24,
                        child: ClipOval(
                          child: Image.network(
                            user.photoURL,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Container(
              //   height: MediaQuery.of(context).size.height,
              //   width: MediaQuery.of(context).size.width,
              //   margin: EdgeInsets.only(
              //       bottom: panelMinHeight,
              //       top: MediaQuery.of(context).size.height -
              //           panelMinHeight -
              //           suggestionHeight),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
