import 'package:flutter/material.dart';
import 'package:frontend/components/text_field_container.dart';
import 'package:frontend/screens/login/components/background.dart';

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              alignment: Alignment.topLeft,
              child: IconButton(
                color: Colors.white,
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
              )),
          SizedBox(
            height: size.height * 0.6,
          ),
          RoundedInputField(
            hintText: "Your Email",
            onChanged: (String value) {},
          ),
          RoundedPasswordField(
            hintText: "Password",
            onChanged: (String value) {},
          ),
        ],
      ),
    );
  }
}
