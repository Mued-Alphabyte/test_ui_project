import 'dart:convert';

import 'package:get/get.dart';

class UserResponse {
  int page;
  int perPage;
  int total;
  int totalPages;
  List<User> data;
  Support support;


  UserResponse({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
    required this.support,
  });

  // Factory method to create a UserResponse object from JSON
  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      page: json['page'],
      perPage: json['per_page'],
      total: json['total'],
      totalPages: json['total_pages'],
      data: List<User>.from(json['data'].map((x) => User.fromJson(x))),
      support: Support.fromJson(json['support']),
    );
  }

  // Convert UserResponse object to JSON
  Map<String, dynamic> toJson() {
    return {
      "page": page,
      "per_page": perPage,
      "total": total,
      "total_pages": totalPages,
      "data": List<dynamic>.from(data.map((x) => x.toJson())),
      "support": support.toJson(),
    };
  }
}

class User {
  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;
  RxBool isFavorite = false.obs;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  // Factory method to create a User object from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }

  // Convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "avatar": avatar,
    };
  }
}

class Support {
  String url;
  String text;

  Support({
    required this.url,
    required this.text,
  });

  // Factory method to create a Support object from JSON
  factory Support.fromJson(Map<String, dynamic> json) {
    return Support(
      url: json['url'],
      text: json['text'],
    );
  }

  // Convert Support object to JSON
  Map<String, dynamic> toJson() {
    return {
      "url": url,
      "text": text,
    };
  }
}

// Function to parse JSON string into UserResponse object
UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

// Function to convert UserResponse object back to JSON string
String userResponseToJson(UserResponse data) =>
    json.encode(data.toJson());
