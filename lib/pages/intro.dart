import 'package:flutter/material.dart';
import 'package:lmsnotifier/database.dart';
import 'package:lmsnotifier/parser.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  TextEditingController userController;
  TextEditingController keyController;

  @override
  void initState() {
    super.initState();
    userController = TextEditingController();
    keyController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: userController,
            decoration: InputDecoration(helperText: 'Username'),
          ),
          TextField(
            controller: keyController,
            obscureText: true,
            decoration: InputDecoration(helperText: 'Password'),
          ),
          MaterialButton(
            onPressed: () {
              putCredentials(userController.text, keyController.text);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ScraperLayer(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
