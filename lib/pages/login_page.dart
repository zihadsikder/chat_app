// import 'package:chat_app/components/my_button.dart';
// import 'package:chat_app/components/my_text_field.dart';
// import 'package:flutter/material.dart';
//
// import '../services/auth/auth_service.dart';
//
// class LoginPage extends StatelessWidget {
//   ///email and pw text controller
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _pwController = TextEditingController();
//
//   /// tap to go to register page
//   final void Function()? onTap;
//
//   LoginPage({super.key, required this.onTap});
//
//   /// login method
//   void login(BuildContext context) async {
//     /// auth service
//     final authService = AuthService();
//
//     /// try login
//     try {
//       await authService.signInWithEmailPassword(
//           _emailController.text, _pwController.text);
//     }
//
//     /// catch any errors
//     catch (e) {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text(e.toString()),
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             /// logo
//             Icon(
//               Icons.message,
//               size: 60,
//               color: Theme.of(context).colorScheme.primary,
//             ),
//             const SizedBox(height: 50),
//
//             /// welcome back message
//             Text(
//               "Welcome back, you've been missed",
//               style: TextStyle(
//                   color: Theme.of(context).colorScheme.primary, fontSize: 16),
//             ),
//             const SizedBox(height: 25),
//
//             /// email textField
//             MyTextField(
//               hintText: 'Email',
//               obscureText: false,
//               controller: _emailController,
//             ),
//             const SizedBox(height: 10),
//
//             /// pw textField
//             MyTextField(
//               hintText: 'Password',
//               obscureText: true,
//               controller: _pwController,
//             ),
//             const SizedBox(height: 25),
//
//             /// login button
//             MyButton(
//               text: 'Log In',
//               onTap: () => login(context),
//             ),
//             const SizedBox(height: 25),
//
//             /// register now
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Not a member?',
//                   style:
//                       TextStyle(color: Theme.of(context).colorScheme.primary),
//                 ),
//                 GestureDetector(
//                   onTap: onTap,
//                   child: Text(
//                     'Register Now',
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Theme.of(context).colorScheme.primary),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_text_field.dart';
import 'package:flutter/material.dart';
import '../services/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  bool _isLoading = false;

  /// login method
  void login() async {
    setState(() {
      _isLoading = true;
    });

    final authService = AuthService();

    try {
      await authService.signInWithEmailPassword(
          _emailController.text, _pwController.text);
      // Navigate to the home page or dashboard
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/chat_logo.png'),
            const SizedBox(height: 50),
            Text(
              "Welcome back, you've been missed",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 25),
            MyTextField(
              hintText: 'Email',
              obscureText: false,
              controller: _emailController,
            ),
            const SizedBox(height: 10),
            MyTextField(
              hintText: 'Password',
              obscureText: true,
              controller: _pwController,
            ),
            const SizedBox(height: 25),
            _isLoading
                ? const CircularProgressIndicator()
                : MyButton(
                    text: 'Log In',
                    onTap: login,
                  ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not a member?',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    ' Register Now',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
