import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const UserTile({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(4),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                /// Icon
                CircleAvatar(
                    radius: 8,
                    backgroundColor: Theme.of(context).colorScheme.background,
                    child: const Icon(
                      Icons.person,
                      size: 12,
                    )),
                const SizedBox(width: 8.0),

                /// user name
                Text(text),
              ],
            ),
          )),
    );
  }
}
