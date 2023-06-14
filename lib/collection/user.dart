import 'package:isar/isar.dart';
part 'user.g.dart';

@collection
class User {
  Id id = Isar.autoIncrement;
  int? userId;
  String? title;
  String? body;
}
