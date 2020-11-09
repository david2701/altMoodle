import 'package:hive/hive.dart';

part 'credentials.g.dart';

@HiveType(typeId: 0)
class Credentials {
  @HiveField(0)
  final String user;
  @HiveField(1)
  final String key;

  Credentials({this.user, this.key});
}
