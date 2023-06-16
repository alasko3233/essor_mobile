// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    this.success,
    this.token,
    this.name,
    this.isActive,
    this.data,
    this.message,
  });

  final bool? success;
  final String? token;
  final String? name;
  final int? isActive;
  final Data? data;
  final String? message;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        success: json["success"],
        token: json["token"],
        name: json["name"],
        isActive: json["is_active"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "token": token,
        "name": name,
        "is_active": isActive,
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  Data({
    this.token,
    this.name,
    this.isActive,
  });

  final String? token;
  final String? name;
  final int? isActive;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        name: json["name"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "name": name,
        "is_active": isActive,
      };
}
