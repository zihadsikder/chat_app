import 'package:chat_app/auth/login_or_registration.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/themes/light_mode.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      home: LoginOrRegistration(),
    );
  }
}

