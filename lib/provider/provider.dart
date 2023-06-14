import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:isar_riverpod_test/collection/category.dart';
import 'package:isar_riverpod_test/collection/rutine.dart';
import 'package:isar_riverpod_test/isarController/isar.dart';

final rutineProvider =
    AsyncNotifierProvider<RoutineNotifier, List<Routine>>(RoutineNotifier.new);

final rutineStreamProvider = StreamProvider(
  (ref) => isar.routines.where().build().watch(fireImmediately: true),
);
final categoryStreamProvider = StreamProvider(
  (ref) => isar.categorys.where().build().watch(fireImmediately: true),
);

class RoutineNotifier extends AsyncNotifier<List<Routine>> {
  @override
  build() async {
    return _fetchData();
  }

  FutureOr<List<Routine>> _fetchData() async =>
      await isar.routines.where().findAll();

  // add data-------
  addNewName({name}) async {
    final newName = await Routine()
      ..name = name;

    await isar.writeTxn(() async => isar.routines.put(newName));
  }

  addCategory({name}) async {
    final newCategory = await Category()
      ..name = name;
    isar.writeTxn(() async {
      await isar.categorys.put(newCategory);
    });
  }

  deleteName({id}) {
    return isar.writeTxn(
      () async {
        isar.routines.delete(id);
      },
    );
  }

  updateName({id, name}) async {
    await isar.writeTxn(
      () async {
        final getId = await isar.routines.get(id);
        getId!..name = name;
        await isar.routines.put(getId);
      },
    );
  }
}
