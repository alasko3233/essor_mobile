// To parse this JSON data, do
//
//     final journal = journalFromJson(jsonString);

import 'dart:convert';

Journal journalFromJson(String str) => Journal.fromJson(json.decode(str));

String journalToJson(Journal data) => json.encode(data.toJson());

class Journal {
  Journal({
    required this.posts,
    required this.principale,
    required this.secondaire,
    required this.tertiaire,
    required this.categorie,
    required this.videos,
    required this.mostviews,
    required this.categories,
    required this.subcategories,
  });

  List<Principale> posts;
  Principale principale;
  Principale secondaire;
  Principale tertiaire;
  List<Categor> categorie;
  List<Video> videos;
  List<Principale> mostviews;
  List<Categor> categories;
  Principale subcategories;

  factory Journal.fromJson(Map<String, dynamic> json) => Journal(
        posts: List<Principale>.from(
            json["posts"].map((x) => Principale.fromJson(x))),
        principale: Principale.fromJson(json["principale"]),
        secondaire: Principale.fromJson(json["secondaire"]),
        tertiaire: Principale.fromJson(json["tertiaire"]),
        categorie: List<Categor>.from(
            json["categorie"].map((x) => Categor.fromJson(x))),
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
        mostviews: List<Principale>.from(
            json["mostviews"].map((x) => Principale.fromJson(x))),
        categories: List<Categor>.from(
            json["categories"].map((x) => Categor.fromJson(x))),
        subcategories: Principale.fromJson(json["subcategories"]),
      );

  Map<String, dynamic> toJson() => {
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
        "principale": principale.toJson(),
        "secondaire": secondaire.toJson(),
        "tertiaire": tertiaire.toJson(),
        "categorie": List<dynamic>.from(categorie.map((x) => x.toJson())),
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
        "mostviews": List<dynamic>.from(mostviews.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "subcategories": subcategories.toJson(),
      };
}

class Categor {
  Categor({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.position,
  });

  int id;
  String name;
  String slug;
  dynamic description;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int position;

  factory Categor.fromJson(Map<String, dynamic> json) => Categor(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "position": position,
      };
}

class Principale {
  Principale({
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
  int? views;
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

  factory Principale.fromJson(Map<String, dynamic> json) => Principale(
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

enum Priority { SECONDAIRE, TERTIAIRE, PRINCIPALE, AUCUNE }

final priorityValues = EnumValues({
  "aucune": Priority.AUCUNE,
  "principale": Priority.PRINCIPALE,
  "secondaire": Priority.SECONDAIRE,
  "tertiaire": Priority.TERTIAIRE
});

class Video {
  Video({
    required this.id,
    required this.link,
    required this.title,
    this.slug,
    this.description,
    this.content,
    required this.categoryId,
    required this.authorId,
    required this.isPublic,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  int id;
  String link;
  String title;
  dynamic slug;
  String? description;
  dynamic content;
  int categoryId;
  int authorId;
  int isPublic;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        link: json["link"],
        title: json["title"],
        slug: json["slug"],
        description: json["description"],
        content: json["content"],
        categoryId: json["category_id"],
        authorId: json["author_id"],
        isPublic: json["is_public"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"] == null
            ? null
            : DateTime.parse(json["deleted_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
        "title": title,
        "slug": slug,
        "description": description,
        "content": content,
        "category_id": categoryId,
        "author_id": authorId,
        "is_public": isPublic,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt?.toIso8601String(),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
