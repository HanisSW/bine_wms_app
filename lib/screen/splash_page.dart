import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wms_project/screen/login_page.dart';

class SplashPage extends StatefulWidget {
  const   SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe6f3ff),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/images/logo.png'),
          ),
          SizedBox(
            height: 30,
          ),
          CircularProgressIndicator(
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  startTime() async {
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
          (Route<dynamic> route) => false,
        );
      },
    );
  }
}
