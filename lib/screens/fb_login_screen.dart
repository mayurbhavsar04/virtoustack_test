import 'dart:convert' as JSON;

import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:virtoustack_test_app/screens/home_screen.dart';

class FbLoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FbLoginScreen();
  }
}

class _FbLoginScreen extends State<FbLoginScreen> {
  Map userProfile;
  String userName;
  bool _isLoading = false;
  final facebookLogin = FacebookLogin();

  _loginWithFB() async {
    final result = await facebookLogin.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        setState(() {
          userProfile = profile;
          userName = userProfile["name"];
          _isLoading = true;
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => HomeScreen(userName)));
        });
        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() {
          _isLoading = false;
        });
        break;
      case FacebookLoginStatus.error:
        setState(() {
          _isLoading = false;
        });
        break;
    }
  }

  _logout() {
    facebookLogin.logOut();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: _isLoading
          ? Center(
              child: Text("Loading...",
                  style: TextStyle(
                      fontSize: 15.0, color: Theme.of(context).primaryColor)),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Sign In",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Sign in with your facebook account",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: RaisedButton(
                      onPressed: () {
                        _loginWithFB();
                      },
                      color: Color(0xFF3B5998),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/fb_small.png',
                              height: 25,
                              width: 25,
                            ),
                            SizedBox(width: 20),
                            Text(
                              "Sign in with Facebook",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
