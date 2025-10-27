import 'package:meta/meta.dart';
import 'dart:convert';

class QuotesModel {
  final List<Quote> quotes;
  final int total;
  final int skip;
  final int limit;

  QuotesModel({
    required this.quotes,
    required this.total,
    required this.skip,
    required this.limit,
  });

  QuotesModel copyWith({
    List<Quote>? quotes,
    int? total,
    int? skip,
    int? limit,
  }) => QuotesModel(
    quotes: quotes ?? this.quotes,
    total: total ?? this.total,
    skip: skip ?? this.skip,
    limit: limit ?? this.limit,
  );

  factory QuotesModel.fromRawJson(String str) =>
      QuotesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuotesModel.fromJson(Map<String, dynamic> json) => QuotesModel(
    quotes: List<Quote>.from(json["quotes"].map((x) => Quote.fromJson(x))),
    total: json["total"],
    skip: json["skip"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "quotes": List<dynamic>.from(quotes.map((x) => x.toJson())),
    "total": total,
    "skip": skip,
    "limit": limit,
  };
}

class Quote {
  final int id;
  final String quote;
  final String author;

  Quote({required this.id, required this.quote, required this.author});

  Quote copyWith({int? id, String? quote, String? author}) => Quote(
    id: id ?? this.id,
    quote: quote ?? this.quote,
    author: author ?? this.author,
  );

  factory Quote.fromRawJson(String str) => Quote.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Quote.fromJson(Map<String, dynamic> json) =>
      Quote(id: json["id"], quote: json["quote"], author: json["author"]);

  Map<String, dynamic> toJson() => {"id": id, "quote": quote, "author": author};
}
