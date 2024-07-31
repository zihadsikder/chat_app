import 'package:flutter/material.dart';

class TitleListView extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Icon icon;

  const TitleListView({
    super.key,
    required this.text,
    required this.onPressed, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 25, top: 12),
      child: Row(
        children: [
          /// icon
          icon,
          const SizedBox(width: 8.0,),
          /// title
          Text(text),
          const Spacer(),

          /// onPressed
          IconButton(
              onPressed: onPressed,
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.grey.shade500,
              ))
        ],
      ),
    );
  }
}