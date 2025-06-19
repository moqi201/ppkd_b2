import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ppkd_b2/meet_22/model/user_model.dart';

Future<List<Users>> getUsers() async {
  final response = await http.get(
    Uri.parse('https://reqres.in/api/users?page=2'),
  );
  if(response.statusCode == 200){
    final List<dynamic> jsonResponse = json.decode(response.body)['data'];
    return jsonResponse.map((user) => Users.fromJson(user)).toList();
  }else {
    throw Exception('Failed to load users');
  }
}
