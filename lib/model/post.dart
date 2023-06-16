// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    this.user,
    required this.postauthor,
    required this.postcategoriename,
    required this.post,
    required this.now,
    required this.selections,
    required this.posts,
    this.bandSide,
    required this.bandSides,
  });

  dynamic user;
  String postauthor;
  String postcategoriename;
  PostClass post;
  Now now;
  List<PostClass> selections;
  List<PostClass> posts;
  dynamic bandSide;
  List<dynamic> bandSides;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        user: json["user"],
        postauthor: json["postauthor"],
        postcategoriename: json["postcategoriename"],
        post: PostClass.fromJson(json["post"]),
        now: Now.fromJson(json["now"]),
        selections: List<PostClass>.from(
            json["selections"].map((x) => PostClass.fromJson(x))),
        posts: List<PostClass>.from(
            json["posts"].map((x) => PostClass.fromJson(x))),
        bandSide: json["bandSide"],
        bandSides: List<dynamic>.from(json["bandSides"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "postauthor": postauthor,
        "postcategoriename": postcategoriename,
        "post": post.toJson(),
        "now": now.toJson(),
        "selections": List<dynamic>.from(selections.map((x) => x.toJson())),
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
        "bandSide": bandSide,
        "bandSides": List<dynamic>.from(bandSides.map((x) => x)),
      };
}

class Now {
  Now({
    required this.year,
    required this.month,
    required this.day,
    required this.dayOfWeek,
    required this.dayOfYear,
    required this.hour,
    required this.minute,
    required this.second,
    required this.micro,
    required this.timestamp,
    required this.formatted,
    required this.timezone,
  });

  int year;
  int month;
  int day;
  int dayOfWeek;
  int dayOfYear;
  int hour;
  int minute;
  int second;
  int micro;
  int timestamp;
  DateTime formatted;
  Timezone timezone;

  factory Now.fromJson(Map<String, dynamic> json) => Now(
        year: json["year"],
        month: json["month"],
        day: json["day"],
        dayOfWeek: json["dayOfWeek"],
        dayOfYear: json["dayOfYear"],
        hour: json["hour"],
        minute: json["minute"],
        second: json["second"],
        micro: json["micro"],
        timestamp: json["timestamp"],
        formatted: DateTime.parse(json["formatted"]),
        timezone: Timezone.fromJson(json["timezone"]),
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "month": month,
        "day": day,
        "dayOfWeek": dayOfWeek,
        "dayOfYear": dayOfYear,
        "hour": hour,
        "minute": minute,
        "second": second,
        "micro": micro,
        "timestamp": timestamp,
        "formatted": formatted.toIso8601String(),
        "timezone": timezone.toJson(),
      };
}

class Timezone {
  Timezone({
    required this.timezoneType,
    required this.timezone,
  });

  int timezoneType;
  String timezone;

  factory Timezone.fromJson(Map<String, dynamic> json) => Timezone(
        timezoneType: json["timezone_type"],
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "timezone_type": timezoneType,
        "timezone": timezone,
      };
}

class PostClass {
  PostClass({
    required this.id,
    required this.title,
    required this.slug,
    required this.image,
    required this.description,
    required this.content,
    this.categoryId,
    required this.authorId,
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
    this.category,
    this.author,
  });

  int id;
  String title;
  String slug;
  String image;
  String description;
  String content;
  int? categoryId;
  int authorId;
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
  Category? category;
  Author? author;

  factory PostClass.fromJson(Map<String, dynamic> json) => PostClass(
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
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        author: json["author"] == null ? null : Author.fromJson(json["author"]),
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
        "category": category?.toJson(),
        "author": author?.toJson(),
      };
}

class Author {
  Author({
    required this.id,
    required this.firstname,
    required this.lastname,
    this.slug,
    required this.email,
    this.phone,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.image,
  });

  int id;
  String firstname;
  String lastname;
  dynamic slug;
  String email;
  dynamic phone;
  dynamic description;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  dynamic image;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        slug: json["slug"],
        email: json["email"],
        phone: json["phone"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "slug": slug,
        "email": email,
        "phone": phone,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "image": image,
      };
}

class Category {
  Category({
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

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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

enum Priority { PRINCIPALE, SECONDAIRE, AUCUNE, TERTIAIRE }

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
