import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../home/components/home_screen.dart';
import './components/body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Homescreen();
            } else {
              return Body();
            }
          },
        ),
      );
}
