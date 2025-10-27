import 'package:meta/meta.dart';
import 'dart:convert';

class CommentsModel {
  final List<Comment> comments;
  final int total;
  final int skip;
  final int limit;

  CommentsModel({
    required this.comments,
    required this.total,
    required this.skip,
    required this.limit,
  });

  CommentsModel copyWith({
    List<Comment>? comments,
    int? total,
    int? skip,
    int? limit,
  }) => CommentsModel(
    comments: comments ?? this.comments,
    total: total ?? this.total,
    skip: skip ?? this.skip,
    limit: limit ?? this.limit,
  );

  factory CommentsModel.fromRawJson(String str) =>
      CommentsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
    comments: List<Comment>.from(
      json["comments"].map((x) => Comment.fromJson(x)),
    ),
    total: json["total"],
    skip: json["skip"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
    "total": total,
    "skip": skip,
    "limit": limit,
  };
}

class Comment {
  final int id;
  final String body;
  final int postId;
  final int likes;
  final User user;

  Comment({
    required this.id,
    required this.body,
    required this.postId,
    required this.likes,
    required this.user,
  });

  Comment copyWith({
    int? id,
    String? body,
    int? postId,
    int? likes,
    User? user,
  }) => Comment(
    id: id ?? this.id,
    body: body ?? this.body,
    postId: postId ?? this.postId,
    likes: likes ?? this.likes,
    user: user ?? this.user,
  );

  factory Comment.fromRawJson(String str) => Comment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
    body: json["body"],
    postId: json["postId"],
    likes: json["likes"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "body": body,
    "postId": postId,
    "likes": likes,
    "user": user.toJson(),
  };
}

class User {
  final int id;
  final String username;
  final String fullName;

  User({required this.id, required this.username, required this.fullName});

  User copyWith({int? id, String? username, String? fullName}) => User(
    id: id ?? this.id,
    username: username ?? this.username,
    fullName: fullName ?? this.fullName,
  );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    fullName: json["fullName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "fullName": fullName,
  };
}
