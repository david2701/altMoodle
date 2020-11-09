import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:icalendar_parser/icalendar_parser.dart';
import 'package:lmsnotifier/database.dart';
import 'package:lmsnotifier/widgets/assignmentTile.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'models/calendarItem.dart';

List items = [];

Future getEvents(String icsString) async {
  ICalendar iCalendar = ICalendar.fromString(icsString);
  for (var item in iCalendar.data) {
    print(item.toString());
    items.add(CalendarItem.fromMap(item));
  }
  putCalendarItems(items);
  return items;
}

class ScraperLayer extends StatefulWidget {
  @override
  _ScraperLayerState createState() => _ScraperLayerState();
}

class _ScraperLayerState extends State<ScraperLayer> {
  WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    getItems();
  }

  initGetEvents() async {
    getCredentials().then(
      (creds) async => await login(creds.user, creds.key),
    );
    await getCalendarUrl();
    getUrl().then(
      (value) => getICS(value).then(
        (icsString) => getEvents(icsString),
      ),
    );
    setState(() {});
  }

  getItems() async {
    List list = [];
    list = await getCalendarItems();
    setState(() {
      items = list;
    });
  }

  login(String username, String password) {
    try {
      _webViewController.evaluateJavascript('''
      var email = document.getElementById("username");
      var password = document.getElementById("password");
      var loginBtn = document.getElementById("loginbtn");
      email.value = "$username";
      password.value = "$password";
      loginBtn.click();
    ''');
    } catch (e) {
      print(e);
    }
  }

  getCalendarUrl() async {
    try {
      await Future.delayed(
          const Duration(seconds: 2),
          () => _webViewController
              .loadUrl('https://195832.logineonrw-lms.de/calendar/export.php'));
      await Future.delayed(
        const Duration(seconds: 2),
        () => _webViewController.evaluateJavascript('''
      var myRadio = document.getElementById("id_events_exportevents_all");
      var thisMonthRadio = document.getElementById("id_period_timeperiod_monthnow");

      myRadio.click();
      thisMonthRadio.click();
      '''),
      );
      Future.delayed(
        const Duration(seconds: 1),
        () => _webViewController.evaluateJavascript('''
      var generateBtn = document.getElementById("id_generateurl");
      
      generateBtn.click();
      '''),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<String> getUrl() async {
    String url;
    await Future.delayed(Duration(seconds: 5),
        (() async => url = await _webViewController.evaluateJavascript('''
            var a = document.getElementsByClassName("generalbox calendarurl"); 
            a[0].innerText.substring(14);
            ''')));
    print(url);
    return url;
  }

  Future getICS(String url) async {
    Dio dio = Dio();
    Response response = await dio.get(
      url.replaceAll('"', ''),
      options: Options(
        responseType: ResponseType.plain,
        followRedirects: false,
      ),
    );
    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: 'https://195832.logineonrw-lms.de/',
          onWebViewCreated: (WebViewController webViewController) {
            _webViewController = webViewController;
          },
        ),
        Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () async => initGetEvents(),
          ),
          body: ListView.builder(
            itemCount: items.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return AssignmentListTile(
                name: items.elementAt(index).name,
                uid: items.elementAt(index).uid,
                type: items.elementAt(index).type,
                description: items.elementAt(index).description,
                categories: items.elementAt(index).categories,
                dtstamp: items.elementAt(index).dtstamp,
              );
            },
          ),
        )
      ],
    );
  }
}