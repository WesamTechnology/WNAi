import 'package:dio/dio.dart';
import 'package:news_app/models/article_model.dart';

class NewsService {
  final dio = Dio();

  Future<List<ArticleModel>> getHttp(String category) async {
    try {
      final Response response = await dio.get(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=40853e6a11ed4a7cb41e299d1139cdc2&category=$category',
      );
      Map<String, dynamic> jsonData = response.data;
      List<dynamic> articles = jsonData['articles'];
      List<ArticleModel> articleList = [];

      for (var article in articles) {
        if (article["title"] != null) {
          ArticleModel articleModel = ArticleModel(
            image: article["urlToImage"],
            title: article["title"],
            subtitle: article["description"],
          );
          articleList.add(articleModel);
        }
      }
      return articleList;
    } catch (e) {
      print("Error fetching news: $e");
      return [];
    }
  }
}
