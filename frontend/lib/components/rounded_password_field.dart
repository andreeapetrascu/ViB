import 'package:flutter/material.dart';
import 'package:frontend/components/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final hintText;
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key? key,
    this.hintText,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          icon: const Icon(
            Icons.lock,
            color: Color.fromARGB(255, 48, 65, 73),
          ),
          suffixIcon: const Icon(
            Icons.visibility,
            color: Color.fromARGB(255, 48, 65, 73),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
