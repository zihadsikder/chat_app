import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Welcome to Chat App. This Privacy Policy explains how we handle any information collected when you use our mobile application. Please read this privacy policy carefully. If you do not agree with the terms of this privacy policy, please do not access the application.'),
                Text(
                  '1. Information We Collect',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Here only we collect your Email',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                    'We want to assure you that we do not collect any personal information without email, usage data, or device information when you use the Chat App.'),
                Text(
                  '2. How We Use Your Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                    'We use email ID for sent & get message'),
                Text(
                  '3. Sharing Your Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                    'As we do not collect any personal data without email, there is no information to share with third parties.'),
                Text(
                  '4. Security of Your Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                    'We take your privacy seriously. We still implement security measures to protect the integrity and security of the app and your interaction with it.'),
                Text(
                  '5. Changes to This Privacy Policy',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                    'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page. You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.'),
                Text(
                  '6. Contact Us',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                    'If you have any questions or concerns about this Privacy Policy, please contact us at:'),
                Text('Email: [islanditltd@gmail.com]'),
                Text('Thank you for using the Chat App!'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}