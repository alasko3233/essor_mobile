// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.phone,
    this.civilite,
    this.isActive,
    this.receivePromotion,
    this.receiveUpdate,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.postcode,
    this.city,
    this.countryId,
    this.image,
    this.endsAt,
    this.modePayment,
  });

  final int? id;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? phone;
  final String? civilite;
  final int? isActive;
  final int? receivePromotion;
  final int? receiveUpdate;
  final dynamic? emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic? deletedAt;
  final dynamic? postcode;
  final dynamic? city;
  final dynamic? countryId;
  final dynamic? image;
  final DateTime? endsAt;
  final String? modePayment;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        phone: json["phone"],
        civilite: json["civilite"],
        isActive: json["is_active"],
        receivePromotion: json["receive_promotion"],
        receiveUpdate: json["receive_update"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        postcode: json["postcode"],
        city: json["city"],
        countryId: json["country_id"],
        image: json["image"],
        endsAt: DateTime.parse(json["ends_at"]),
        modePayment: json["modePayment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "phone": phone,
        "civilite": civilite,
        "is_active": isActive,
        "receive_promotion": receivePromotion,
        "receive_update": receiveUpdate,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "postcode": postcode,
        "city": city,
        "country_id": countryId,
        "image": image,
        "ends_at":
            "${endsAt?.year.toString().padLeft(4, '0')}-${endsAt?.month.toString().padLeft(2, '0')}-${endsAt?.day.toString().padLeft(2, '0')}",
        "modePayment": modePayment,
      };
}
