import 'package:flutter/material.dart';

class CustomizeInputTextField extends StatelessWidget {
  final String hintText;
  final Color hintColor, iconColor, textColor;
  final IconData iconData;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final bool obsecureText;

  const CustomizeInputTextField({
    Key? key,
    required this.hintText,
    required this.hintColor,
    required this.iconColor,
    required this.textColor,
    required this.iconData,
    required this.controller,
    this.suffixIcon,
    required this.obsecureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintColor,
        ),
        prefixIcon: Icon(
          iconData,
          color: iconColor,
        ),
        suffixIcon: suffixIcon,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      controller: controller,
      obscureText: obsecureText,
      validator: (val) {
        if (val!.isEmpty) {
          return '$hintText is not empty.';
        }
        return null;
      },
    );
  }
}
