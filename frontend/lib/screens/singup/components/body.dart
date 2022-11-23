import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/backend/utils.dart';
import 'package:frontend/components/already_have_an_account_check.dart';
import 'package:frontend/components/roundedbutton.dart';
import 'package:frontend/components/rounded_input_field.dart';
import 'package:frontend/components/rounded_password_field.dart';
import 'package:frontend/components/text_field_container.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/login/login_screen.dart';
import 'package:frontend/screens/singup/components/background.dart';

import '../../home/components/home_screen.dart';

class Body extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final Widget child;

  Body({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(top: 0),
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
                height: size.height * 0.25,
              ),
              const Positioned(
                top: 30,
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
              SizedBox(
                height: size.height * 0.1,
              ),
              // RoundedInputField(
              //   hintText: "Your Email",
              //   onChanged: (String value) {},
              // ),
              TextFieldContainer(
                child: TextFormField(
                  controller: emailController,
                  //onChanged: onChanged,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 48, 65, 73),
                    ),
                    hintText: "Your Email",
                    border: InputBorder.none,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Enter a valid email!'
                          : null,
                ),
              ),
              // RoundedPasswordField(
              //   hintText: "Password",
              //   onChanged: (String value) {},
              // ),
              TextFieldContainer(
                child: TextFormField(
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value != null && value.length < 5
                      ? 'Enter min. 5 characters'
                      : null,
                ),
              ),
              // RoundedPasswordField(
              //   hintText: "Confirm Password",
              //   onChanged: (String value) {},
              // ),
              SizedBox(
                height: size.height * 0.01,
              ),
              RoundedButton(
                text: "Create Account",
                press: () async {
                  final isValid = formKey.currentState!.validate();
                  if (!isValid) return;
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) =>
                          const Center(child: CircularProgressIndicator()));
                  try {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                  } on FirebaseAuthException catch (e) {
                    // ignore: avoid_print
                    print(e);
                    Utils.showSnackBar(e.message);
                  }
                  navigatorKey.currentState!.popUntil((route) => route.isFirst);
                },
              ),
              SizedBox(
                height: size.height * 0.03,
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
      ),
    );
  }
}
