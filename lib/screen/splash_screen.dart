import 'package:flutter/material.dart';
import 'package:note_bloc_app/screen/base_screen.dart';
import 'package:note_bloc_app/services/api_services.dart';
import 'package:note_bloc_app/widgets/customize_circle_progress_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isDone = false;
  Future<void> loggedIn() async {
    try {
      await ApiServices().login('duong1998@gmail.com', '123456').then((value) {
        if (value != null) {
          setState(() {
            isDone = true;
          });
          Navigator.pushNamedAndRemoveUntil(context, '/note', (route) => false);
        } else {
          setState(() {
            isDone = true;
          });
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false);
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  void initState() {
    loggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomizeCircleProgressBar(isDone: isDone,),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Loading application ...',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
      isShowBottomNav: false,
    );
  }
}
