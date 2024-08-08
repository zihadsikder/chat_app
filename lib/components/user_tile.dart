import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../themes/theme_provider.dart';

class UserTile extends StatelessWidget {
  final String text;
  final String userText;
  final void Function()? onTap;

  /// define a list of colors
  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.cyan,
    Colors.amber,
  ];

  UserTile({
    super.key,
    required this.text,
    this.onTap,
    required this.userText,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    /// Assign a color based on the first letter of the userText
    int colorIndex = userText.codeUnitAt(0) % colors.length;
    Color firstLetterColor = colors[colorIndex];
    return GestureDetector(
      onTap: onTap,
      child: Container(
          // decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary,borderRadius: BorderRadius.circular(4),),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                /// Icon
                CircleAvatar(
                  radius: 16,
                  backgroundColor: isDarkMode
                      ? Theme.of(context).colorScheme.inversePrimary
                      : Colors.grey.shade300,

                  // child: Icon(Icons.person,size: 24,color: isDarkMode? Colors.white : Colors.black,),
                  child: Text(
                    userText,
                    style: TextStyle(
                      //color: isDarkMode ? Colors.white : Colors.black,
                      color: firstLetterColor,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),

                /// user name
                Text(
                  text,
                  style: const TextStyle(fontSize: 16),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.grey.shade500,
                )
              ],
            ),
          )),
    );
  }
}
