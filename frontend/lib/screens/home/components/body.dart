import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: const [
        SizedBox(
          height: 50,
        ),
        Align(
          //alignment: Alignment.center,
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
      ],
    );
  }
}
