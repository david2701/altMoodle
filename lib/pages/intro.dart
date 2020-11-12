import 'package:flutter/material.dart';
import 'package:lmsnotifier/database.dart';
import 'package:lmsnotifier/parser.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  TextEditingController keyController, urlController, userController;
  bool canLogin;

  @override
  void initState() {
    super.initState();
    canLogin = false;
    userController = TextEditingController();
    keyController = TextEditingController();
    urlController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'login',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
              ),
              textAlign: TextAlign.left,
            ),
            Column(
              children: [
                TextFormField(
                  autocorrect: false,
                  controller: userController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    helperText: 'Username',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                  autocorrect: false,
                  controller: keyController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    helperText: 'Password',
                    prefixIcon: Icon(Icons.security),
                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value.startsWith('http')) {
                      return "Do not include leading protocol!";
                    } else if (value.endsWith('/')) {
                      return 'Do not include trailing /';
                    } else if (value.isEmpty) {
                      return "You need to provide this!";
                    }
                    canLogin = true;
                    return null;
                  },
                  autocorrect: false,
                  controller: urlController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    helperText: 'Moodle URL',
                    prefixIcon: Icon(Icons.web),
                    suffix: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => new AlertDialog(
                            title: Text(
                              'How to format the URL correctly',
                            ),
                            content: Text(
                              'Do not include the protocol at the beginning (http:// or https://) and do not put a leading / at the end.',
                            ),
                          ),
                          barrierDismissible: true,
                        );
                      },
                      child: Icon(Icons.help),
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: RaisedButton(
                child: Text('Login'),
                onPressed: () async {
                  if (canLogin) {
                    await putCredentials(
                        userController.text, keyController.text);
                    await putUrl(urlController.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ScraperLayer(),
                      ),
                    );
                  } else
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text("Can't login"),
                        content: Text(
                          "The Form either isn't filled entirely or you made a typo",
                        ),
                        actions: [
                          OutlineButton(
                            child: Text('OK'),
                            onPressed: () => Navigator.pop(context),
                          )
                        ],
                      ),
                    );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
