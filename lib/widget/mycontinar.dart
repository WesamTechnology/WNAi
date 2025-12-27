import 'package:flutter/material.dart';
import 'package:news_app/widget/category_mdel.dart';

class Mycontinar extends StatelessWidget {
  const Mycontinar({super.key, required this.categoryModel});
  final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        height: 100,
        width: 160,
        decoration: BoxDecoration(
          //color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(categoryModel.image),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.darken,
            ),
          ),
        ),
        child: Center(child: Text("${categoryModel.name}",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)),
      ),
    );
  }
}
