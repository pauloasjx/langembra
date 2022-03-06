import 'dart:math';

import 'package:langembra/models/remaining.dart';

class Article {
  String? url;
  final Remaining remaining;

  Article(this.remaining, {this.url});

  Article.fromJson(Map<String, dynamic> json)
      : remaining = Remaining.fromJson(json['remaining']);

  Map<String, dynamic> toJson() => {'remaining': remaining.toJson()};

  String getSentence() {
    final rnd = Random();

    final sentences = this
        .remaining
        .sections
        .map((s) => s.sentences)
        .expand((e) => e)
        .toList();

    return sentences[rnd.nextInt(sentences.length)];
  }
}
