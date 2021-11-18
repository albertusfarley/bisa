import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/controllers/ticket_controller.dart';
import 'package:parkir/models/location_name.dart';
import 'package:parkir/models/ticket.dart';
import 'package:parkir/screens/ticket_screen.dart';
import 'package:parkir/services/database.dart';
import 'package:parkir/widgets/custom_text.dart';
import 'package:parkir/widgets/loading.dart';
import 'package:parkir/widgets/parking_painter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ParkingScreen extends StatefulWidget {
  final String id;
  final String name;

  const ParkingScreen({required this.id, required this.name, Key? key})
      : super(key: key);

  @override
  _ParkingScreenState createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  final TicketController _ticket = Get.find<TicketController>();

  int turns = 0;
  bool isFullscreen = false;
  final Color emptyColor = const Color(0xffeeeef4);
  final Color occupiedColor = const Color(0xff1d88f6);
  final PanelController _panel = PanelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
            stream: DatabaseService().getParkingStream(id: widget.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return const SizedBox.shrink();

              Map data = snapshot.data!.data() as Map;
              int available = data['slots']
                  .values
                  .where((e) => e['empty'] == true)
                  .toList()
                  .length;

              double fullness = available / data['slots'].length;

              return Container(
                constraints: BoxConstraints.expand(),
                child: Stack(
                  children: [
                    Center(
                      child: InteractiveViewer(
                        minScale: 1,
                        maxScale: 2.5,
                        child: Center(
                          child: RotatedBox(
                            quarterTurns: turns,
                            child: Container(
                              height: Get.width,
                              width: Get.width,
                              child: CustomPaint(
                                foregroundPainter: ParkingPainter(data: data),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (!isFullscreen)
                          AppBar(
                            title:
                                LocationName(raw: widget.name).widget(size: 16),
                            actions: [
                              Obx(() {
                                return IconButton(
                                    onPressed: () => Get.to(TicketScreen()),
                                    icon: Icon(
                                      Icons.description_rounded,
                                      color: _ticket.data.value == null
                                          ? dark
                                          : primary,
                                    ));
                              })
                            ],
                          ),
                        Container(
                          height: 2,
                          child: LinearProgressIndicator(
                            backgroundColor: lightPrimary,
                            color: fullness == 1 ? Colors.red : primary,
                            value: fullness,
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 100,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 52,
                                width: 52,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: isFullscreen
                                        ? Colors.transparent
                                        : lightGrey,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            turns = turns == 0 ? 1 : 0;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.rotate_right,
                                          color: turns == 1 ? primary : dark,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isFullscreen = !isFullscreen;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.fullscreen,
                                          color: isFullscreen ? primary : dark,
                                        )),
                                    PopupMenuButton(
                                        icon: const Icon(Icons.info_outline),
                                        iconSize: 22,
                                        elevation: 4,
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        color: white,
                                        itemBuilder: (context) => [
                                              PopupMenuItem(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 4),
                                                height: 0,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 8,
                                                      width: 8,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: occupiedColor),
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    customText(
                                                        text: 'Occupied',
                                                        color: darkGrey,
                                                        alignment:
                                                            TextAlign.center,
                                                        size: 12),
                                                  ],
                                                ),
                                              ),
                                              PopupMenuItem(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 16,
                                                      vertical: 4),
                                                  height: 0,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 8,
                                                        width: 8,
                                                        decoration:
                                                            BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color:
                                                                    emptyColor),
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      customText(
                                                          text: 'Empty',
                                                          color: darkGrey,
                                                          alignment:
                                                              TextAlign.center,
                                                          size: 12),
                                                    ],
                                                  ))
                                            ]),
                                  ],
                                ),
                              ),
                              Obx(() {
                                if (_ticket.data.value == null) {
                                  return GestureDetector(
                                      onTap: () async {
                                        _ticket.setTicket(
                                            ticket: Ticket(
                                                name: widget.name,
                                                id: DateTime.now()
                                                    .millisecondsSinceEpoch));
                                        Get.to(() => TicketScreen())
                                            ?.then((value) {
                                          setState(() {});
                                        });
                                        // _showTicket(ticket: ticket);
                                      },
                                      child: Container(
                                        height: 52,
                                        width: 52,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: primary),
                                        child: const Icon(
                                          Icons.login,
                                          color: white,
                                          size: 28,
                                        ),
                                      ));
                                } else {
                                  return Container(
                                    height: 52,
                                    width: 52,
                                  );
                                }
                              })
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }));
  }
}
