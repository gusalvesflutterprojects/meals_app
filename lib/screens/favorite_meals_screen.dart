import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/meal_item.dart';

import '../dummy-data.dart';

import '../models/meal.dart';

class FavoriteMealsScreen extends StatelessWidget {
  static const routeName = '/favorite-meals';
  final List<String> favorites;
  final Function addFavorite;
  final Function removeFavorite;

  FavoriteMealsScreen(
    this.favorites,
    this.addFavorite,
    this.removeFavorite,
  );

  @override
  Widget build(BuildContext context) {
    final List<Meal> favoriteMeals =
        DUMMY_MEALS.where((meal) => favorites.contains(meal.id)).toList();

    return Scaffold(
      body: ListView.builder(
        itemBuilder: (ctx, i) {
          return MealItem(
            id: favoriteMeals[i].id,
            title: favoriteMeals[i].title,
            imageUrl: favoriteMeals[i].imageUrl,
            duration: favoriteMeals[i].duration,
            complexity: favoriteMeals[i].complexity,
            affordability: favoriteMeals[i].affordability,
            addFavorite: addFavorite,
            removeFavorite: removeFavorite,
          );
        },
        itemCount: favoriteMeals.length,
      ),
    );
  }
}
