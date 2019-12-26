import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/meal_item.dart';

import '../dummy-data.dart';

import '../models/meal.dart';

class FavoriteMealsScreen extends StatelessWidget {
  static const routeName = '/favorite-meals';
  final List<String> favorites;
  final Function toggleFavorite;
  final Function isMealFavorite;

  FavoriteMealsScreen(this.favorites, this.toggleFavorite, this.isMealFavorite);

  @override
  Widget build(BuildContext context) {
    final List<Meal> favoriteMeals =
        DUMMY_MEALS.where((meal) => favorites.contains(meal.id)).toList();

    return Scaffold(
        body: favoriteMeals.isNotEmpty
            ? ListView.builder(
                itemBuilder: (ctx, i) {
                  return MealItem(
                    id: favoriteMeals[i].id,
                    title: favoriteMeals[i].title,
                    imageUrl: favoriteMeals[i].imageUrl,
                    duration: favoriteMeals[i].duration,
                    complexity: favoriteMeals[i].complexity,
                    affordability: favoriteMeals[i].affordability,
                    toggleFavorite: toggleFavorite,
                    isMealFavorite: isMealFavorite,
                    fromFavoritesPage: true,
                  );
                },
                itemCount: favoriteMeals.length,
              )
            : Center(
                child: Text('You have no favorites - start adding some!'),
              ));
  }
}
