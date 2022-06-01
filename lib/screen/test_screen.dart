import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Test screen build');
    return const Scaffold(
      body: Center(
        child: Text('Test Screen'),
      ),
    );
  }
}
