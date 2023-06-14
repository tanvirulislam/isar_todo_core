import 'package:isar/isar.dart';
import 'package:isar_riverpod_test/collection/category.dart';
import 'package:isar_riverpod_test/collection/rutine.dart';
import 'package:path_provider/path_provider.dart';

late Isar isar;

class IsarService {
  static Future<void> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [RoutineSchema, CategorySchema],
      directory: dir.path,
    );
  }
}
