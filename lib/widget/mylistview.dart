import 'package:flutter/material.dart';
import 'package:news_app/screens/Home_page.dart';
import 'package:news_app/screens/category_page.dart';
import 'category_mdel.dart';
import 'mycontinar.dart';

class Mylistview extends StatelessWidget {
  Mylistview({super.key});

  final List<CategoryModel> categories = [
    CategoryModel(image: "images/continer/sport.jpg", name: "رياضة"),
    CategoryModel(image: "images/continer/entertainment.jpg", name: "ترفيه"),
    CategoryModel(image: "images/continer/business.jpg", name: "اقتصاد"),
    CategoryModel(image: "images/continer/health.jpg", name: "صحة"),
    CategoryModel(image: "images/continer/science.jpg", name: "علوم"),
    CategoryModel(image: "images/continer/technology.jpg", name: "تكنولوجيا"),
    CategoryModel(image: "images/continer/general.jpg", name: "عام"),
  ];

  // Helper map to get API key from Arabic name
  String getApiKey(String arabicName) {
    switch (arabicName) {
      case "رياضة":
        return "sport";
      case "ترفيه":
        return "entertainment";
      case "اقتصاد":
        return "business";
      case "صحة":
        return "health";
      case "علوم":
        return "science";
      case "تكنولوجيا":
        return "technology";
      case "عام":
        return "general";
      default:
        return "general";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () {
              String categoryKey = getApiKey(categories[i].name);

              if (categoryKey == 'general') {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false,
                );
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (context) => CategoryPage(
                          category: categoryKey,
                          title: categories[i].name,
                        ),
                  ),
                );
              }
            },
            child: Mycontinar(categoryModel: categories[i]),
          );
        },
      ),
    );
  }
}
