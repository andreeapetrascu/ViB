import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/already_have_an_account_check.dart';
import 'package:frontend/components/roundedbutton.dart';
import 'package:frontend/components/text_field_container.dart';
import 'package:frontend/screens/home/components/home_screen.dart';
import 'package:frontend/screens/login/components/background.dart';
import 'package:frontend/screens/singup/singup_screen.dart';

class Body extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
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
            // RoundedInputField(
            //   hintText: "Your Email",
            //   onChanged: (String value) {},
            // ),
            TextFieldContainer(
              child: TextField(
                controller: emailController,
                //onChanged: onChanged,
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 48, 65, 73),
                    ),
                    hintText: "Your Email",
                    border: InputBorder.none),
              ),
            ),
            // RoundedPasswordField(
            //   hintText: "Password",
            //   onChanged: (String value) {},
            // ),
            TextFieldContainer(
              child: TextField(
                controller: passwordController,
                obscureText: true,
                //onChanged: onChanged,
                decoration: const InputDecoration(
                  hintText: "Password",
                  icon: Icon(
                    Icons.lock,
                    color: Color.fromARGB(255, 48, 65, 73),
                  ),
                  suffixIcon: Icon(
                    Icons.visibility,
                    color: Color.fromARGB(255, 48, 65, 73),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            RoundedButton(
              text: "LOGIN",
              press: () async {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                );
              },
            ),
            SizedBox(
              height: size.height * 0.2,
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
      ),
    );
  }
}
