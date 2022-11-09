import 'package:flutter/material.dart';
import 'package:frontend/components/already_have_an_account_check.dart';
import 'package:frontend/components/roundedbutton.dart';
import 'package:frontend/components/rounded_input_field.dart';
import 'package:frontend/components/rounded_password_field.dart';
import 'package:frontend/screens/login/login_screen.dart';
import 'package:frontend/screens/singup/components/background.dart';

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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
    );
  }
}
