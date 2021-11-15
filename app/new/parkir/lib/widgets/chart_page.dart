import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/models/bar_data.dart';
import 'package:parkir/services/time_utils.dart';
import 'package:parkir/widgets/bar_chart_widget.dart';
import 'package:parkir/widgets/custom_text.dart';

class ChartPage extends StatefulWidget {
  final Map popular;

  const ChartPage({required this.popular, Key? key}) : super(key: key);

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  String _selectedDay = TimeUtils.todayName();
  late PageController _timesController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timesController = PageController(
        initialPage: TimeUtils.days.indexOf(_selectedDay), keepPage: true);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: verticalPadding),
          child: Row(
            children: [
              customText(text: 'Popular Times', weight: FontWeight.bold),
              const SizedBox(
                width: horizontalItemPadding,
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 6, bottom: 6, left: 16, right: 8),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(24)),
                child: DropdownButton<String>(
                  dropdownColor: white,
                  iconEnabledColor: primary,
                  isDense: true,
                  value: _selectedDay,
                  underline: const SizedBox.shrink(),
                  items: TimeUtils.days.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: customText(text: value, color: darkGrey),
                    );
                  }).toList(),
                  onChanged: (name) {
                    setState(() {
                      _selectedDay = name!;
                      _timesController.jumpToPage(TimeUtils.days.indexOf(name));
                    });
                  },
                ),
              )
            ],
          ),
        ),
        verticalItemSpacer(),
        verticalItemSpacer(),
        Container(
          height: Get.width / 3,
          child: PageView(
            controller: _timesController,
            children: [
              for (String day in TimeUtils.days)
                BarChartWidget(
                  data: widget.popular.keys.contains(day)
                      ? BarData(raw: widget.popular[day]).data
                      : [],
                  height: Get.width / 3,
                ),
            ],
            onPageChanged: (index) {
              print('page $index');
              setState(() {
                _selectedDay = TimeUtils.days[index];
              });
            },
          ),
        ),
        verticalItemSpacer(half: true),
        DotsIndicator(
          decorator: DotsDecorator(
            color: Colors.grey[300]!,
            activeColor: primary,
            activeSize: Size(4, 4),
            size: Size(4, 4),
          ),
          dotsCount: TimeUtils.days.length,
          position: TimeUtils.days.indexOf(_selectedDay).toDouble(),
        ),
      ],
    );
  }
}
