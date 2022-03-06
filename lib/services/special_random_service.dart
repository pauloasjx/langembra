import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:html/parser.dart';
import 'package:langembra/models/special_random.dart';

class SpecialRandomService {
  static String url = "https://en.wikipedia.org/wiki/Special:Random";

  Future<SpecialRandom> generate() async {
    final response = await Dio().get(url);
    final responseNodes = parse(response.data);
    final scriptTag = responseNodes.getElementsByTagName("script").first;

    final raw = scriptTag.text
        .split(";")
        .where((element) => element.contains("RLCONF"))
        .first
        .replaceFirst("RLCONF=", "");

    final content = json.decode(raw);

    return SpecialRandom.fromJson(content);
  }
}
