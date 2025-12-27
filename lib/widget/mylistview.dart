import 'package:flutter/material.dart';
import 'package:news_app/screens/Home_page.dart';
import 'package:news_app/screens/category_page.dart';
import 'category_mdel.dart';
import 'mycontinar.dart';

class Mylistview extends StatelessWidget {
  Mylistview({super.key});

  final List<CategoryModel> categories = [
    CategoryModel(image: "images/continer/sport.jpg", name: "Sport"),
    CategoryModel(
      image: "images/continer/entertainment.jpg",
      name: "Entertainment",
    ),
    CategoryModel(image: "images/continer/business.jpg", name: "Business"),
    CategoryModel(image: "images/continer/health.jpg", name: "Health"),
    CategoryModel(image: "images/continer/science.jpg", name: "Science"),
    CategoryModel(image: "images/continer/technology.jpg", name: "Technology"),
    CategoryModel(image: "images/continer/general.jpg", name: "General"),
  ];

  // List categoryNews removed as we use dynamic navigation

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () {
              // Extract category name for API (lowercase)
              String categoryName = categories[i].name.toLowerCase();
              if (categoryName == 'general') {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false,
                );
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (context) => CategoryPage(
                          category: categoryName,
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
