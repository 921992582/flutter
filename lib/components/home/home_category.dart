import 'package:flutter/material.dart';
import 'package:flutter_test_project/viewmodels/home.dart';

class HomeCategory extends StatefulWidget {
  // 分类数据
  final List<CategoryItem> categoryList;
  const HomeCategory({super.key, required this.categoryList});

  @override
  State<HomeCategory> createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categoryList.length,
        itemBuilder: (BuildContext context, int index) {
          final item = widget.categoryList[index];
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 234, 230, 230),
              borderRadius: BorderRadius.circular(40),
            ),
            height: 80,
            width: 80,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(item.picture, width: 40, height: 40),
                Text(item.name),
              ],
            ),
          );
        },
      ),
    );
  }
}
