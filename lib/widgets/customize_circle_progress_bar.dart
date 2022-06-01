import 'package:flutter/material.dart';

class CustomizeCircleProgressBar extends StatefulWidget {
  final bool isDone;
  const CustomizeCircleProgressBar({Key? key, required this. isDone}) : super(key: key);

  @override
  _CustomizeCircleProgressBarState createState() =>
      _CustomizeCircleProgressBarState();
}

class _CustomizeCircleProgressBarState extends State<CustomizeCircleProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    _animationController.repeat(reverse: false);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    if (widget.isDone == true) {
      _animationController.stop();
    }
    else if (widget.isDone == false){
      _animationController.forward();
    }
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircularProgressIndicator(
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
          value: _animation.value == 0.3 ? 0 : 0.3 + _animation.value,
        ),
        CircularProgressIndicator(
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
          value: _animation.value == 0.25 ? 0 : 0.25 + _animation.value,
        ),
        CircularProgressIndicator(
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
          value: _animation.value == 0.2 ? 0 : _animation.value,
        ),
      ],
    );
  }
}
