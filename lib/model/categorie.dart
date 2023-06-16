// To parse this JSON data, do
//
//     final categorie = categorieFromJson(jsonString);

import 'dart:convert';

Categorie categorieFromJson(String str) => Categorie.fromJson(json.decode(str));

String categorieToJson(Categorie data) => json.encode(data.toJson());

class Categorie {
  Categorie({
    required this.posts,
    required this.mostviews,
  });

  List<Mostview> posts;
  List<Mostview> mostviews;

  factory Categorie.fromJson(Map<String, dynamic> json) => Categorie(
        posts:
            List<Mostview>.from(json["posts"].map((x) => Mostview.fromJson(x))),
        mostviews: List<Mostview>.from(
            json["mostviews"].map((x) => Mostview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
        "mostviews": List<dynamic>.from(mostviews.map((x) => x.toJson())),
      };
}

class Mostview {
  Mostview({
    required this.id,
    required this.title,
    required this.slug,
    required this.image,
    required this.description,
    required this.content,
    required this.categoryId,
    this.authorId,
    required this.views,
    required this.isPublic,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.isAlert,
    required this.isEdito,
    required this.subjectedSubscription,
    this.priority,
    this.update,
    this.motcleId,
  });

  int id;
  String title;
  String slug;
  String image;
  String description;
  String content;
  int categoryId;
  int? authorId;
  int views;
  int isPublic;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int isAlert;
  int isEdito;
  int subjectedSubscription;
  Priority? priority;
  DateTime? update;
  int? motcleId;

  factory Mostview.fromJson(Map<String, dynamic> json) => Mostview(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        image: json["image"],
        description: json["description"],
        content: json["content"],
        categoryId: json["category_id"],
        authorId: json["author_id"],
        views: json["views"],
        isPublic: json["is_public"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        isAlert: json["is_alert"],
        isEdito: json["is_edito"],
        subjectedSubscription: json["subjected_subscription"],
        priority: priorityValues.map[json["priority"]],
        update: json["update"] == null ? null : DateTime.parse(json["update"]),
        motcleId: json["motcle_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "image": image,
        "description": description,
        "content": content,
        "category_id": categoryId,
        "author_id": authorId,
        "views": views,
        "is_public": isPublic,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "is_alert": isAlert,
        "is_edito": isEdito,
        "subjected_subscription": subjectedSubscription,
        "priority": priorityValues.reverse[priority],
        "update": update?.toIso8601String(),
        "motcle_id": motcleId,
      };
}

enum Priority { TERTIAIRE, PRINCIPALE, SECONDAIRE, AUCUNE }

final priorityValues = EnumValues({
  "aucune": Priority.AUCUNE,
  "principale": Priority.PRINCIPALE,
  "secondaire": Priority.SECONDAIRE,
  "tertiaire": Priority.TERTIAIRE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
