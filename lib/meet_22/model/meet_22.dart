import 'package:http/http.dart' as http;
import 'dart:convert';

class Welcome {
  int page;
  int perPage;
  int total;
  int totalPages;
  List<Datum> data;
  Support support;

  Welcome({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
    required this.support,
  });
}

class Datum {
  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  Datum({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });
}

class Support {
  String url;
  String text;

  Support({required this.url, required this.text});
}
