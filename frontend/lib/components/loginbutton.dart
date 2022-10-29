import 'package:flutter/material.dart';
import 'package:frontend/screens/login/login_screen.dart';

class LoginButton extends StatelessWidget {
  final String text;
  const LoginButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width * 0.8,
        margin: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(29),
            child: TextButton(
              style: TextButton.styleFrom(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  backgroundColor: Colors.teal[100]),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
              child: Text(text,
                  style: TextStyle(
                    color: Colors.indigo[900],
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
            )));
  }
}
