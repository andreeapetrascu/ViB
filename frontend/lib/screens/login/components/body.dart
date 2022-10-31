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
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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
