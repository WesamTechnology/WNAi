import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'services/auth_service.dart';
import 'routes/app_pages.dart';
import 'controllers/news_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  await Get.putAsync(() => AuthService().init());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Inject dependency globally - better to use Binding if possible but sticking to existing pattern for NewsController unless refactoring it
    Get.put(NewsController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WNAi',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
