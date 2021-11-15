import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/widgets/custom_text.dart';
import 'package:parkir/widgets/location_list.dart';

class SearchArea extends StatefulWidget {
  const SearchArea({Key? key}) : super(key: key);

  @override
  _SearchAreaState createState() => _SearchAreaState();
}

class _SearchAreaState extends State<SearchArea> {
  TextEditingController _searchController = TextEditingController();

  clearText() => setState(() {
        _searchController.text = '';
      });

  @override
  Widget build(BuildContext context) {
    List result = []
        .where((item) => item['name']
            .toString()
            .toLowerCase()
            .contains(_searchController.text))
        .toList();

    print(result);
    if (result.isEmpty) {
      print('result == null');
    } else {
      print('result != null, result = $result');
    }

    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: verticalPadding, horizontal: horizontalPadding),
              child: TextField(
                onChanged: (text) => setState(() {}),
                controller: _searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  prefixIcon: const Icon(
                    Ionicons.search,
                    color: dark,
                  ),
                  suffixIcon: Visibility(
                    visible: _searchController.text != '',
                    child: IconButton(
                        onPressed: () => clearText(),
                        icon: const Icon(
                          Ionicons.close_circle,
                          color: grey,
                        )),
                  ),
                  hintText: 'Find parking location',
                  hintStyle: const TextStyle(color: grey),
                  filled: true,
                  fillColor: grey.withOpacity(.05),
                  focusColor: dark,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: grey.withOpacity(.2))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: grey.withOpacity(.2))),
                ),
              ),
            ),
            result.isEmpty
                ? Column(
                    children: [
                      verticalSpacer(),
                      customText(text: '[¬º-°]¬', color: grey, size: 48),
                      verticalSpacer(),
                      customText(
                          text:
                              'No location found for \'${_searchController.text}\'',
                          color: grey),
                      verticalItemSpacer(half: true),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                        color: primary,
                        onPressed: () {
                          clearText();
                        },
                        child: customText(
                            text: 'Clear',
                            color: white,
                            weight: FontWeight.bold),
                      ),
                    ],
                  )
                : LocationList(locations: result)
          ],
        ),
      ),
    );
  }
}
