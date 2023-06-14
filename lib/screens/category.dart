import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_riverpod_test/provider/provider.dart';

// ignore: must_be_immutable
class CategoryScreen extends ConsumerWidget {
  CategoryScreen({super.key});
  var _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Category')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(controller: _categoryController),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(rutineProvider.notifier)
                      .addCategory(name: _categoryController.text);
                  _categoryController.clear();
                },
                child: Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
