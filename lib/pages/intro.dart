import 'package:flutter/material.dart';
import 'package:lmsnotifier/database.dart';
import 'package:lmsnotifier/parser.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  TextEditingController keyController, urlController, userController;

  @override
  void initState() {
    super.initState();
    userController = TextEditingController();
    keyController = TextEditingController();
    urlController = TextEditingController();
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
          TextField(
            controller: urlController,
            decoration: InputDecoration(helperText: 'Moodle URL'),
          ),
          Text(
              'Formatting:\nWithout http:// or https:// at the beginning AND with leading /'),
          MaterialButton(
            child: Text('Login'),
            onPressed: () {
              putCredentials(userController.text, keyController.text);
              putUrl(urlController.text);
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
