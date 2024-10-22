import 'dart:convert';
import 'package:get_data_user/model/model.dart';
import 'package:http/http.dart' as http;

class Repository {
  final _baseUrl = 'https://671667503fcb11b265d2435d.mockapi.io/user';

  Future getData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<User> user = it.map((e) => User.fromJson(e)).toList();
        return user;
      }
    } catch (e) {
      // print(e.toString());
    }
  }
}
