import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width * 0.8,
        margin: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(29),
            child: TextButton(
              style: TextButton.styleFrom(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  backgroundColor: Colors.teal[100]),
              onPressed: press,
              child: Text(text,
                  style: TextStyle(
                    color: Colors.indigo[900],
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
            )));
  }
}
