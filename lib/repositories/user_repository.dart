import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:suitmedia_submission/models/user.dart';

class UserRepository{
  final String _base = "https://reqres.in/api";

  Future<List<User>> fetchUser(int page, int limit) async {
    final response = await http.get(Uri.parse("$_base/users?page=$page&per_page=$limit"));
    final data = json.decode(response.body)['data'];

    return List<User>.from(data.map((e)=>User.fromJson(e)));
  }
}