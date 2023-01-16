import 'package:flutter/material.dart';
import 'package:frontend/screens/components/background.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();

  const Body({
    super.key,
  });
}

class _BodyState extends State<Body> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: SingleChildScrollView(child: Column(children: <Widget>[])));
  }
}
