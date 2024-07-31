import 'package:chat_app/pages/privacy_page.dart';
import 'package:chat_app/themes/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/text_list_view.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Column(
        children: [
          themeMode(context),
          TitleListView(
            text: 'Privacy Policy',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacyPage()));
            },
            icon: const Icon(Icons.privacy_tip_outlined),
          ),
          TitleListView(
            text: 'Rate Us',
            onPressed: () {},
            icon: const Icon(Icons.star_rate_outlined),
          ),
          TitleListView(
            text: 'Share',
            onPressed: () {},
            icon: const Icon(Icons.share_outlined),
          ),
        ],
      ),
    );
  }

  Container themeMode(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(right: 25, left: 25, top: 12),
      padding: const EdgeInsets.only(right: 12, left: 12, top: 16, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// dark mode
          const Text('Dark Mode'),

          /// switch toggle
          CupertinoSwitch(
            value: Provider.of<ThemeProvider>(context)
                .isDarkMode, // listen: true to rebuild when theme changes
            onChanged: (value) {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
    );
  }
}
