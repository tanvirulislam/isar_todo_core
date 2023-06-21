import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_riverpod_test/collection/category.dart';
import 'package:isar_riverpod_test/provider/provider.dart';
import 'package:isar_riverpod_test/screens/category.dart';

// ignore: must_be_immutable
class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  var _nameController = TextEditingController();
  var _updateNameController = TextEditingController();
  List<Category> categories = [];
  Category? dropdownValue;

  List<String> name = ['apple', 'samsung'];
  String? value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final routineProviderRef = ref.watch(rutineProvider);
    final rutineStreamProviderref = ref.watch(rutineStreamProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Todo'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryScreen(),
                  ),
                );
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(),
              ),
              SizedBox(
                height: 60,
                child: DropdownButton(
                  isExpanded: true,
                  value: dropdownValue,
                  items: categories
                      .map(
                        (Category e) => DropdownMenuItem(
                          value: e.name,
                          child: Text(
                            e.name.toString(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    ref
                        .read(rutineProvider.notifier)
                        .updateInstantCategory(newCategory: dropdownValue);
                  },
                ),
              ),
              DropdownButton(
                isExpanded: true,
                value: value,
                items: name
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
                onChanged: (value) {},
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(rutineProvider.notifier)
                      .addNewName(name: _nameController.text);
                  _nameController.clear();
                },
                child: Text('Submit'),
              ),
              Expanded(
                child: rutineStreamProviderref.when(
                  data: (data) {
                    return ListView(
                      shrinkWrap: true,
                      children: [
                        for (final task in data)
                          Card(
                            child: ListTile(
                              leading: Text(task.id.toString()),
                              title: Text(task.name.toString()),
                              // subtitle: Text(task.categoryName.toString()),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) => Container(
                                          height: 600,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  controller:
                                                      _updateNameController,
                                                  decoration: InputDecoration(
                                                    hintText: task.name,
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    ref
                                                        .read(rutineProvider
                                                            .notifier)
                                                        .updateName(
                                                          id: task.id,
                                                          name:
                                                              _updateNameController
                                                                  .text,
                                                        );
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Update'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.edit_outlined),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      ref
                                          .read(rutineProvider.notifier)
                                          .deleteName(id: task.id);
                                    },
                                    icon: Icon(Icons.delete_outline),
                                  ),
                                ],
                              ),
                            ),
                          )
                      ],
                    );
                  },
                  error: (error, stackTrace) =>
                      Center(child: Text(error.toString())),
                  loading: () => Center(child: CircularProgressIndicator()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
