import 'package:chat_app/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_or_registration.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          /// user is logged in
          if (snapshot.hasData) {
            return HomePage();
          }

          /// user is NOT logged in
          else {
            return const LoginOrRegistration();
          }
        },
      ),
    );
  }
}
