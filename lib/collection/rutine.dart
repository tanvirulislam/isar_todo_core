import 'package:isar/isar.dart';
import 'package:isar_riverpod_test/collection/category.dart';
part 'rutine.g.dart';

@collection
class Routine {
  Id id = Isar.autoIncrement;

  String? name;

  final categoryName = IsarLink<Category>();
}
