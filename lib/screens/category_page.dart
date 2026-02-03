import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/screens/chat_screen.dart';
import 'package:news_app/widget/mylistnews.dart';
import 'package:news_app/widget/mylistview.dart';

class CategoryPage extends StatelessWidget {
  final String category;
  final String title;

  const CategoryPage({super.key, required this.category, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              " اخبار",
              style: TextStyle(
                fontSize: 18,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: Mylistview()),
            SliverToBoxAdapter(child: SizedBox(height: 32)),
            Mylistnews(category: category),
          ],
        ),
      ),
    );
  }
}
