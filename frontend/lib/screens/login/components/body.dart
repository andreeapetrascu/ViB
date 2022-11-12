import 'package:flutter/material.dart';
import 'package:frontend/components/already_have_an_account_check.dart';
import 'package:frontend/components/roundedbutton.dart';
import 'package:frontend/screens/home/components/home_screen.dart';
import 'package:frontend/screens/login/components/background.dart';
import 'package:frontend/screens/singup/singup_screen.dart';

import '../../../components/rounded_input_field.dart';
import '../../../components/rounded_password_field.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(top: 20.0),
              alignment: Alignment.topLeft,
              child: IconButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const Homescreen();
                  }));
                },
                icon: const Icon(Icons.arrow_back),
              )),
          SizedBox(
            height: size.height * 0.3,
          ),
          RoundedInputField(
            hintText: "Your Email",
            onChanged: (String value) {},
          ),
          RoundedPasswordField(
            hintText: "Password",
            onChanged: (String value) {},
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          RoundedButton(
            text: "LOGIN",
            press: () {},
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SingupScreen();
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
