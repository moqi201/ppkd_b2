// To parse this JSON data, do
//
//     final listUsersResponse = listUsersResponseFromJson(jsonString);

import 'dart:convert';

ListUsersResponse listUsersResponseFromJson(String str) =>
    ListUsersResponse.fromJson(json.decode(str));

String listUsersResponseToJson(ListUsersResponse data) =>
    json.encode(data.toJson());

class ListUsersResponse {
  int page;
  int perPage;
  int total;
  int totalPages;
  List<Users> data;
  Support support;

  ListUsersResponse({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
    required this.support,
  });

  factory ListUsersResponse.fromJson(Map<String, dynamic> json) =>
      ListUsersResponse(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: List<Users>.from(json["data"].map((x) => Users.fromJson(x))),
        support: Support.fromJson(json["support"]),
      );

  Map<String, dynamic> toJson() => {
    "page": page,
    "per_page": perPage,
    "total": total,
    "total_pages": totalPages,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "support": support.toJson(),
  };
}

class Users {
  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  Users({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    id: json["id"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "avatar": avatar,
  };
}

class Support {
  String url;
  String text;

  Support({required this.url, required this.text});

  factory Support.fromJson(Map<String, dynamic> json) =>
      Support(url: json["url"], text: json["text"]);

  Map<String, dynamic> toJson() => {"url": url, "text": text};
}
