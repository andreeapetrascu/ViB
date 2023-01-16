import 'package:flutter/material.dart';
import 'package:frontend/components/roundedbutton.dart';
import 'package:frontend/screens/components/background.dart';
import 'package:frontend/screens/login/login_screen.dart';
import 'package:frontend/screens/singup/singup_screen.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
      Container(
          margin: const EdgeInsets.only(top: 50, bottom: 50),
          child: const Align(
            alignment: Alignment.center,
          )),
      RoundedButton(
          text: "Log In",
          press: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const LoginScreen();
            }));
          }),
      RoundedButton(
          text: "Create Account",
          press: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const SingupScreen();
            }));
          })
    ])));
  }
}
