import 'package:flutter/material.dart';

import '../screens/category_meals_screen.dart';

import '../models/meal.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final Color color;
  final Function toggleFavorite;
  final Function isMealFavorite;
  final Map<String, bool> filters;
  final List<Meal> categoryMeals;

  CategoryItem(
    this.title,
    this.color,
    this.toggleFavorite,
    this.isMealFavorite,
    this.filters,
    this.categoryMeals,
  );

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoryMealsScreen.routeName,
      arguments: {
        'title': title,
        'categoryMeals': categoryMeals,
        'toggleFavorite': toggleFavorite,
        'isMealFavorite': isMealFavorite,
        'filters': filters,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Stack(children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.title,
          ),
          Positioned(
            child: Text(
              '${categoryMeals.length}',
              style: Theme.of(context).textTheme.title,
            ),
            bottom: 0,
            right: 0,
          ),
        ]),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
