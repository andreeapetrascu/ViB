import 'package:flutter/material.dart';
import 'package:frontend/components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final emailController = TextEditingController();
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  RoundedInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: emailController,
        onChanged: onChanged,
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: const Color.fromARGB(255, 48, 65, 73),
            ),
            hintText: hintText,
            border: InputBorder.none),
      ),
    );
  }
}
