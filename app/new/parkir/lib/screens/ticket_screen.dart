import 'package:barcode/barcode.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/controllers/ticket_controller.dart';
import 'package:parkir/models/location_name.dart';
import 'package:parkir/models/ticket.dart';
import 'package:parkir/widgets/custom_text.dart';
import 'package:parkir/widgets/my_separator.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  ticketData({required String title, required Widget child, Function? onTap}) {
    return GestureDetector(
      onTap: () => onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [customText(text: title, color: grey, size: 12), child],
      ),
    );
  }

  final TicketController _ticket = Get.find<TicketController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_ticket.data.value == null) {
        return Scaffold(
          body: Center(
            child: customText(text: 'You dont have any ticket.'),
          ),
        );
      }

      Ticket ticket = _ticket.data.value!;
      String id = ticket.id.toRadixString(16);

      String date = DateFormat('dd MMM yyyy')
          .format(DateTime.fromMillisecondsSinceEpoch(ticket.id));
      String time = DateFormat('HH:mm')
          .format(DateTime.fromMillisecondsSinceEpoch(ticket.id));

      return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: .0,
            backgroundColor: Color(0xff445cb2),
            title: customText(
                text: 'Parking Ticket',
                color: white,
                size: 16,
                weight: FontWeight.bold),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: white,
              ),
              onPressed: () => Get.back(),
            ),
          ),
          body: Container(
            constraints: BoxConstraints.expand(),
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: horizontalPadding * 2,
                        right: horizontalPadding * 2,
                        bottom: horizontalPadding * 2),
                    color: Color(0xff445cb2),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            constraints: BoxConstraints.expand(),
                            padding: EdgeInsets.symmetric(
                                horizontal: horizontalPadding * 2,
                                vertical: verticalItemPadding),
                            decoration: const BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20))),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: customText(
                                        text:
                                            LocationName(raw: ticket.name).text,
                                        size: 16,
                                        weight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                ticketData(
                                                    title: 'Date',
                                                    child: customText(
                                                      text: date,
                                                    )),
                                                ticketData(
                                                    title: 'Start at',
                                                    child: customText(
                                                      text: time,
                                                    )),
                                                ticketData(
                                                    title: 'Duration',
                                                    child: StreamBuilder(
                                                        stream: Stream.periodic(
                                                            Duration(
                                                                seconds: 1)),
                                                        builder: (context,
                                                            snapshot) {
                                                          int millis = DateTime
                                                                  .now()
                                                              .millisecondsSinceEpoch;
                                                          Duration duration =
                                                              Duration(
                                                                  milliseconds:
                                                                      millis -
                                                                          ticket
                                                                              .id);

                                                          return customText(
                                                              text: duration
                                                                  .toString()
                                                                  .split('.')
                                                                  .first
                                                                  .padLeft(
                                                                      8, "0"));
                                                        }))
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                ticketData(
                                                    title: 'Floor',
                                                    child: TextField(
                                                      controller:
                                                          TextEditingController()
                                                            ..text =
                                                                ticket.floor,
                                                      maxLength: 12,
                                                      minLines: 1,
                                                      maxLines: 1,
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      onSubmitted: (text) {
                                                        ticket.floor = text;
                                                        _ticket.setTicket(
                                                            ticket: ticket);
                                                      },
                                                      style: TextStyle(
                                                          color: dark,
                                                          fontSize: 14),
                                                      scrollPadding:
                                                          EdgeInsets.zero,
                                                      decoration: InputDecoration(
                                                          counterText: "",
                                                          isDense: true,
                                                          contentPadding:
                                                              EdgeInsets.zero,
                                                          hintText:
                                                              'Tap to add',
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .grey[300],
                                                              fontSize: 14),
                                                          labelStyle: TextStyle(
                                                              color: primary),
                                                          border:
                                                              InputBorder.none),
                                                    )),
                                                ticketData(
                                                    title: 'Area',
                                                    child: TextField(
                                                      controller:
                                                          TextEditingController()
                                                            ..text =
                                                                ticket.area,
                                                      maxLength: 12,
                                                      minLines: 1,
                                                      maxLines: 1,
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      onSubmitted: (text) {
                                                        ticket.area = text;
                                                        _ticket.setTicket(
                                                            ticket: ticket);
                                                      },
                                                      style: TextStyle(
                                                          color: dark,
                                                          fontSize: 14),
                                                      scrollPadding:
                                                          EdgeInsets.zero,
                                                      decoration: InputDecoration(
                                                          counterText: "",
                                                          isDense: true,
                                                          contentPadding:
                                                              EdgeInsets.zero,
                                                          hintText:
                                                              'Tap to add',
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .grey[300],
                                                              fontSize: 14),
                                                          labelStyle: TextStyle(
                                                              color: primary),
                                                          border:
                                                              InputBorder.none),
                                                    )),
                                                ticketData(
                                                  title: 'Ticket No.',
                                                  child: customText(
                                                    text: ticket.id
                                                        .toRadixString(16)
                                                        .toUpperCase(),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 32,
                          width: double.infinity,
                          color: const Color(
                            0xff445cb2,
                          ),
                          child: Stack(
                            children: [
                              Container(
                                constraints: const BoxConstraints.expand(),
                                decoration: const BoxDecoration(
                                    color: white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: white, offset: Offset(0, -1)),
                                      BoxShadow(
                                          color: white, offset: Offset(0, 1)),
                                    ]),
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 32,
                                    width: 16,
                                    decoration: const BoxDecoration(
                                        color: Color(0xff445cb2),
                                        borderRadius: BorderRadius.horizontal(
                                            right: Radius.circular(64))),
                                  ),
                                  const Expanded(
                                    child: MySeparator(
                                      color: Color(0xffbdbdbd),
                                    ),
                                  ),
                                  Container(
                                    height: 32,
                                    width: 16,
                                    decoration: const BoxDecoration(
                                        color: Color(0xff445cb2),
                                        borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(64))),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: horizontalPadding * 2,
                                  vertical: verticalPadding),
                              decoration: const BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(20)),
                              ),
                              child: BarcodeWidget(
                                barcode: Barcode.code128(),
                                data: ticket.id.toString(),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: horizontalPadding * 2),
                    constraints: BoxConstraints.expand(),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ticketData(
                            title: 'Price (Estimated)',
                            child: customText(
                                text: 'Rp. 20.000,-',
                                size: 24,
                                weight: FontWeight.bold)),
                        GestureDetector(
                          onTap: () {
                            _ticket.deleteTicket();
                            Get.back();
                          },
                          child: Container(
                            height: 52,
                            width: 52,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.sports_score_rounded,
                              color: white,
                              size: 28,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
