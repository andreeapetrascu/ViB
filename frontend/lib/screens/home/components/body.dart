import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        const Align(
          alignment: Alignment.center,
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
        Container(
            alignment: Alignment.center,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: TextButton(
                  style: TextButton.styleFrom(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 40),
                      backgroundColor: Colors.teal[100]),
                  onPressed: () {},
                  child: Text("LOGIN",
                      style: TextStyle(
                        color: Colors.indigo[900],
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                ))),
      ],
    );
  }
}
