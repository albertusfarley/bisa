import 'package:flutter/material.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/widgets/custom_text.dart';

class RoundedButton extends StatelessWidget {
  final IconData iconData;
  final String text;
  final bool active;
  final Function onPressed;

  const RoundedButton(
      {required this.iconData,
      required this.text,
      required this.onPressed,
      this.active = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                color: active ? primary : Colors.grey[100],
                shape: BoxShape.circle),
            child: Icon(
              iconData,
              color: active ? white : dark,
              size: 28,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          customText(text: text, color: grey, size: 12)
        ],
      ),
    );
  }
}
