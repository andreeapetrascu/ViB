import 'package:flutter/material.dart';
import 'package:frontend/components/already_have_an_account_check.dart';
import 'package:frontend/components/roundedbutton.dart';
import 'package:frontend/components/rounded_input_field.dart';
import 'package:frontend/components/rounded_password_field.dart';
import 'package:frontend/screens/login/login_screen.dart';
import 'package:frontend/screens/singup/components/background.dart';

import '../../home/components/home_screen.dart';

class Body extends StatelessWidget {
  final Widget child;

  const Body({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(top: 20.0),
                alignment: Alignment.topLeft,
                child: IconButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const Homescreen();
                    }));
                  },
                  icon: const Icon(Icons.arrow_back),
                )),
            SizedBox(
              height: size.height * 0.3,
            ),
            const Positioned(
              top: 130,
              child: Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Baloo2',
                  color: Color.fromARGB(255, 173, 226, 236),
                ),
              ),
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (String value) {},
            ),
            RoundedPasswordField(
              hintText: "Password",
              onChanged: (String value) {},
            ),
            RoundedPasswordField(
              hintText: "Confirm Password",
              onChanged: (String value) {},
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoundedButton(
              text: "Create Account",
              press: () {},
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginScreen();
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
