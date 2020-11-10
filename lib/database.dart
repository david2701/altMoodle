import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/calendarItem.dart';
import 'models/credentials.dart';

Box box;

hive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CalendarItemAdapter());
  Hive.registerAdapter(CredentialsAdapter());
  box = await Hive.openBox('box');
}

Future<List> getCalendarItems() async {
  List list = [];
  list = await box.get('calendarItems') ?? [];
  return list;
}

putCalendarItems(List list) async {
  box.put('calendarItems', list);
}

putCredentials(String user, String key) {
  Credentials creds = new Credentials(user: user, key: key);
  box.put('credentials', creds);
}

getCredentials() async {
  return await box.get('credentials');
}

putUrl(String url) async {
  box.put('url', url);
}

Future<String> getUrl() async {
  return await box.get('url');
}
