import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../widgets/empty_list.dart';

import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  @override

  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final String categoryTitle = routeArgs['title'];
    final List<Meal> categoryMeals = routeArgs['categoryMeals'];

    void _removeMeal(String mealId) {
      setState(() => categoryMeals.removeWhere((meal) => mealId == meal.id));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: categoryMeals.length > 0
          ? ListView.builder(
              itemBuilder: (ctx, i) {
                return MealItem(
                  id: categoryMeals[i].id,
                  title: categoryMeals[i].title,
                  imageUrl: categoryMeals[i].imageUrl,
                  duration: categoryMeals[i].duration,
                  complexity: categoryMeals[i].complexity,
                  affordability: categoryMeals[i].affordability,
                  toggleFavorite: routeArgs['toggleFavorite'],
                  isMealFavorite: routeArgs['isMealFavorite'],
                  removeMeal: _removeMeal,
                );
              },
              itemCount: categoryMeals.length,
            )
          : EmptyList(),
    );
  }
}
