import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:virtoustack_test_app/screens/fb_login_screen.dart';
import 'package:virtoustack_test_app/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/image.gif",
              height: 125.0,
              width: 125.0,
            ),
            SizedBox(height: 25),
            Text(
              "Dog's Path",
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
            SizedBox(height: 15),
            Text(
              "by",
              style: TextStyle(
                  fontSize: 15, color: Theme.of(context).primaryColor),
            ),
            SizedBox(height: 15),
            Text(
              "VirtouStack Softwares Pvt. Ltd.",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).primaryColor),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), rout);
  }

  rout() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => FbLoginScreen()));
  }
}
