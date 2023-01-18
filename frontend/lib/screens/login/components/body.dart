import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/backend/utils.dart';
import 'package:frontend/components/already_have_an_account_check.dart';
import 'package:frontend/components/roundedbutton.dart';
import 'package:frontend/components/text_field_container.dart';
import 'package:frontend/screens/home/components/home_screen.dart';
import 'package:frontend/screens/components/background.dart';
import 'package:frontend/screens/singup/singup_screen.dart';

class Body extends StatefulWidget {
  final Widget child;

  @override
  _BodyState createState() => _BodyState();

  const Body({
    super.key,
    required this.child,
  });
}

class _BodyState extends State<Body> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool passwordVisible = false;

  void _toggle() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
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
        height: size.height * 0.27,
      ),
      TextFieldContainer(
        child: TextField(
          controller: emailController,
          decoration: const InputDecoration(
              icon: Icon(
                Icons.person,
                color: Color.fromARGB(255, 48, 65, 73),
              ),
              hintText: "Your Email",
              border: InputBorder.none),
        ),
      ),
      TextFieldContainer(
        child: TextField(
          controller: passwordController,
          obscureText: !passwordVisible,
          decoration: InputDecoration(
            hintText: "Password",
            icon: const Icon(
              Icons.lock,
              color: Color.fromARGB(255, 48, 65, 73),
            ),
            suffixIcon: IconButton(
              color: const Color.fromARGB(255, 48, 65, 73),
              onPressed: _toggle,
              icon: passwordVisible
                  ? const Icon(
                      Icons.visibility,
                      color: Color.fromARGB(255, 48, 65, 73),
                    )
                  : const Icon(
                      Icons.visibility_off,
                      color: Color.fromARGB(255, 48, 65, 73),
                    ),
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
          try {
            await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            );
          } on FirebaseAuthException catch (e) {
            Utils.showSnackBar(e.message);
          }
        },
      ),
      SizedBox(
        height: size.height * 0.2,
      ),
      AlreadyHaveAnAccountCheck(press: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const SingupScreen();
        }));
      })
    ])));
  }
}
