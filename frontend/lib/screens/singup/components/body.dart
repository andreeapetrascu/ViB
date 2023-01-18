import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/backend/utils.dart';
import 'package:frontend/components/already_have_an_account_check.dart';
import 'package:frontend/components/roundedbutton.dart';
import 'package:frontend/components/text_field_container.dart';
import 'package:frontend/screens/login/login_screen.dart';
import 'package:frontend/screens/components/background.dart';
import '../../home/components/home_screen.dart';

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
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool passwordVisible = false;
  bool confirmationVisible = false;

  void _toggle() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  void _toggle2() {
    setState(() {
      confirmationVisible = !confirmationVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: SingleChildScrollView(
            child: Form(
                key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                          child: Text("Sign Up",
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Baloo2',
                                color: Color.fromARGB(255, 173, 226, 236),
                              ))),
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      TextFieldContainer(
                          child: TextFormField(
                        controller: emailController,
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
                      )),
                      TextFieldContainer(
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: !passwordVisible,
                          decoration: InputDecoration(
                              hintText: "Password",
                              border: InputBorder.none,
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
                                          color:
                                              Color.fromARGB(255, 48, 65, 73),
                                        )
                                      : const Icon(
                                          Icons.visibility_off,
                                          color:
                                              Color.fromARGB(255, 48, 65, 73),
                                        ))),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value != null && value.length < 6
                                  ? 'Enter min. 6 characters'
                                  : null,
                        ),
                      ),
                      TextFieldContainer(
                          child: TextFormField(
                        controller: confirmPasswordController,
                        obscureText: !confirmationVisible,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          border: InputBorder.none,
                          icon: const Icon(
                            Icons.lock,
                            color: Color.fromARGB(255, 48, 65, 73),
                          ),
                          suffixIcon: IconButton(
                              color: const Color.fromARGB(255, 48, 65, 73),
                              onPressed: _toggle2,
                              icon: confirmationVisible
                                  ? const Icon(
                                      Icons.visibility,
                                      color: Color.fromARGB(255, 48, 65, 73),
                                    )
                                  : const Icon(
                                      Icons.visibility_off,
                                      color: Color.fromARGB(255, 48, 65, 73),
                                    )),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => value != passwordController.text
                            ? 'Enter the same password!'
                            : null,
                      )),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      RoundedButton(
                          text: "Create Account",
                          press: () async {
                            final isValid = formKey.currentState!.validate();
                            if (!isValid) return;

                            try {
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                            } on FirebaseAuthException catch (e) {
                              Utils.showSnackBar(e.message);
                            }
                          }),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      AlreadyHaveAnAccountCheck(
                          login: false,
                          press: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const LoginScreen();
                            }));
                          })
                    ]))));
  }
}
