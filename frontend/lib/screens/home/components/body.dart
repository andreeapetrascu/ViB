import 'package:flutter/material.dart';
import 'package:frontend/screens/login/login_screen.dart';
import 'package:frontend/screens/singup/singup_screen.dart';

import '../../../components/roundedbutton.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 200, bottom: 50),
          child: const Align(
            alignment: Alignment.center,
            child: Text(
              'ViB',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                fontFamily: 'Baloo2',
                color: Color.fromARGB(255, 173, 226, 236),
              ),
            ),
          ),
        ),
        RoundedButton(
            text: "Log In",
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const LoginScreen();
              }));
            }), //onpressed:  Navigator.of(context).pushAndRemoveUntil(
        //MaterialPageRoute(builder: (context) => PatientDetailsScreen()),
        //(Route<dynamic> route) => false); -> loginbutton.dart!!
        RoundedButton(
          text: "Create Account",
          press: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const SingupScreen();
            }));
          },
        ),
      ],
    );
  }
}
