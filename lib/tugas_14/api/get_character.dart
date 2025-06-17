import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ppkd_b2/tugas_14/model/character_model.dart';

Future<List<CharacterList>> getCar() async {
  final response = await http.get(
    Uri.parse('https://hp-api.onrender.com/api/characters'),
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse.map((json) => CharacterList.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load characters');
  }
}
