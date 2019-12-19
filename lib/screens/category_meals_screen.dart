import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/meal_item.dart';

import '../dummy-data.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;        
    final categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    final categoryMeals = DUMMY_MEALS
        .where((meal) => meal.categories.contains(categoryId))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) {
          return MealItem(
            id: categoryMeals[i].id,
            title: categoryMeals[i].title,
            imageUrl: categoryMeals[i].imageUrl,
            duration: categoryMeals[i].duration,
            complexity: categoryMeals[i].complexity,
            affordability: categoryMeals[i].affordability,
            addFavorite: routeArgs['addFavorite'],
            removeFavorite: routeArgs['removeFavorite'],
            checkFavorite: routeArgs['checkFavorite'],
          );
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
