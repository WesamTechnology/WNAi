import 'package:get/get.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/services/news_service.dart';

class NewsController extends GetxController {
  var articles = <ArticleModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void getNews(String category) async {
    try {
      isLoading(true);
      var fetchedArticles = await NewsService().getHttp(category);
      if (fetchedArticles.isNotEmpty) {
        articles.assignAll(fetchedArticles);
      }
    } catch (e) {
      Get.snackbar("Error", "Error loading news: $e");
    } finally {
      isLoading(false);
    }
  }
}
