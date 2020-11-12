import 'package:flutter/material.dart';
import 'package:lmsnotifier/pages/intro.dart';
import 'package:lmsnotifier/parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await hive();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Better LMS',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.deepPurple,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.deepPurple,
      ),
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    if (_seen) {
      Navigator.of(context)
          .push(new MaterialPageRoute(builder: (context) => ScraperLayer()));
    } else {
      prefs.setBool('seen', true);
      Navigator.of(context)
          .push(new MaterialPageRoute(builder: (context) => SplashScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new CircularProgressIndicator(),
      ),
    );
  }
}
