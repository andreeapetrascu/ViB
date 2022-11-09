import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 50,
              child: Image.asset(
                "assets/images/Vib_logo.png",
                width: size.width * 0.4,
              ),
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
            child,
          ],
        ));
  }
}
