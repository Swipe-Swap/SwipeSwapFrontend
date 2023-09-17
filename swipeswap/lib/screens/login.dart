import 'package:flutter/material.dart';
import 'package:swipeswap/screens/welcome.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:swipeswap/services/auth.dart';
import 'package:swipeswap/utils/constants.dart';

/// Login page
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String name = '';
  String email = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Welcome(
                      currentPage: 4,
                    ),
                  ));
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final login = await AuthService().signInWithGoogle();
            if (login != null) {
              // check if no login errors
              if (context.mounted) {
                Navigator.pushNamed(context, Routes.swaps.toString());
              }
            } else {
              // login error
              //TODO Snackbar
            }
          },
          child: const Text('Sign in with Google'),
        ),
      ),
    );
  }
}

enum _SelectedTab { home, seller, user }
