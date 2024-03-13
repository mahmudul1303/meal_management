import 'package:flutter/material.dart';
import 'package:meal_management/models/category_model.dart';
import 'package:meal_management/screens/meals.dart';

import '../data/dummy_data.dart';
import '../data/meal.dart';
import '../widgets/category_gird_itms.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.onToggleFavourite});
  final void Function(Meal meal) onToggleFavourite;
  void _selecteCategory(BuildContext context, Category category) {
    final filteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MealsScreen(
              title: category.title,
              meals: filteredMeals,
              onToggleFavourite: onToggleFavourite,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Pick Your Categories'),
        // ),
        body: GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: [
        for (final category in availableCategories)
          CategoryGridItems(
            category: category,
            onSelectedCategory: () {
              _selecteCategory(context, category);
            },
          )
      ],
    ));
  }
}
