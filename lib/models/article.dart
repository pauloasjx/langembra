import 'package:langembra/models/remaining.dart';

class Article {
  String? url;
  final Remaining remaining;

  Article(this.remaining);

  Article.fromJson(Map<String, dynamic> json)
      : remaining = Remaining.fromJson(json['remaining']);

  Map<String, dynamic> toJson() => {'remaining': remaining.toJson()};
}
