import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/screens/chat_screen.dart';
import 'package:news_app/widget/mylistnews.dart';
import 'package:news_app/widget/mylistview.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'المساعد الذكي',
        onPressed: () {
          Get.to(() => ChatScreen());
        },
        backgroundColor: Colors.deepPurple,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: const Icon(
          Icons.smart_toy_rounded,
          color: Colors.white,
          size: 30,
        ),
      ),

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "News",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Cloud",
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
            // Using GetX in Mylistnews
            Mylistnews(category: "general"),
          ],
        ),
      ),
    );
  }
}
