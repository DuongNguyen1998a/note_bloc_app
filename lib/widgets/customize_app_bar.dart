import 'package:flutter/material.dart';

class CustomizeAppBar extends StatelessWidget {
  final String title;
  final Widget? child;
  const CustomizeAppBar({Key? key, required this.title, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        child ?? const SizedBox(),
      ],
    );
  }
}
