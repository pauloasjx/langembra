import 'package:dio/dio.dart';
import 'package:langembra/models/article.dart';

class ArticleService {
  Future<Article> fetch(String pageName, {String lang = "en"}) async {
    final url =
        "https://$lang.wikipedia.org/api/rest_v1/page/mobile-sections/$pageName";

    final response = await Dio().get(url);

    return Article.fromJson(response.data)..url = url;
  }
}
