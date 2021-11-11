import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/padding.dart';

class TileButton extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Function onPressed;
  const TileButton(
      {required this.iconData,
      required this.text,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalItemPadding - 4),
      child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 8),
          onTap: () => onPressed(),
          leading: Container(
            padding: const EdgeInsets.all(10),
            child: Icon(
              iconData,
              color: grey,
              size: 16,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[100],
            ),
          ),
          title: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: dark,
              fontSize: 14,
            ),
          ),
          trailing: const Icon(
            Ionicons.chevron_forward,
            color: grey,
            size: 16,
          )),
    );
  }
}
