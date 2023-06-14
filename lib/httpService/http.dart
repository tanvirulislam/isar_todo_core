import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpService {
  Future<void> fetchAPI() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
    }
  }
}
