import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/news_controller.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/widget/news_tile.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Mylistnews extends StatelessWidget {
  final String category;

  Mylistnews({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    // Use tag to have separate states for each category
    final NewsController newsController = Get.put(
      NewsController(),
      tag: category,
    );

    // Initial fetch if needed
    if (newsController.articles.isEmpty && newsController.isLoading.value) {
      newsController.getNews(category);
    }

    // Create a dummy article for skeleton loading
    final ArticleModel dummyArticle = ArticleModel(
      image: "https://via.placeholder.com/150",
      title: "Loading News Title Placeholder line 1",
      subtitle:
          "Loading news description placeholder line 1. Loading news description placeholder line 2.",
    );

    return Obx(() {
      final isLoading = newsController.isLoading.value;
      final articles = newsController.articles;

      if (articles.isEmpty && !isLoading) {
        return SliverToBoxAdapter(
          child: Center(child: Text("No articles found")),
        );
      }

      return SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: isLoading ? 6 : articles.length,
          (context, index) {
            return Skeletonizer(
              enabled: isLoading,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 22.0),
                child: NewsTile(
                  articleModel: isLoading ? dummyArticle : articles[index],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
