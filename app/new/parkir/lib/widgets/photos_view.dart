import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkir/constants/colors.dart';

class PhotosView extends StatefulWidget {
  final List photos;
  const PhotosView({required this.photos, Key? key}) : super(key: key);

  @override
  _PhotosViewState createState() => _PhotosViewState();
}

class _PhotosViewState extends State<PhotosView> {
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox(
            height: Get.width,
            width: Get.width,
            child: PageView.builder(
              itemCount: widget.photos.length,
              itemBuilder: (_, index) {
                return Image.network(
                  widget.photos[index],
                  fit: BoxFit.cover,
                );
              },
              onPageChanged: (index) {
                setState(() {
                  current = index;
                });
              },
            )),
        Positioned(
          bottom: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: DotsIndicator(
                    dotsCount: widget.photos.length,
                    position: current.toDouble(),
                    decorator: DotsDecorator(
                        spacing: const EdgeInsets.symmetric(horizontal: 2),
                        size: const Size(24.0, 2.0),
                        activeSize: const Size(24.0, 2.0),
                        shape: const RoundedRectangleBorder(),
                        activeShape: const RoundedRectangleBorder(),
                        activeColor: white,
                        color: white.withOpacity(.5))),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                height: 24,
                width: Get.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                    boxShadow: [BoxShadow(color: white, offset: Offset(0, 1))]),
              )
            ],
          ),
        )
      ],
    );
  }
}
