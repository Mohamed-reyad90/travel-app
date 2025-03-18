import 'package:flutter/material.dart';
import '../app_Data.dart';
import '../widgets/categories_items.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 7 / 8,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      children:
          CategoriesData.map(
            (categoryData) => CategoriesItems(
              id: categoryData.id,
              title: categoryData.title,
              imageUrl: categoryData.imageUrl,
            ),
          ).toList(),
    );
  }
}
