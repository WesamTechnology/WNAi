import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_app/controllers/news_controller.dart';
import 'package:news_app/screens/Home_page.dart';
import 'package:news_app/screens/splash_screen.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Inject dependency globally
    Get.put(NewsController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WNAi',
      home: SplashScreen(),
    );
  }
}
