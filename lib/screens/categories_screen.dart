import 'package:flutter/material.dart';

import '../dummy-data.dart';
import '../widgets/category_item.dart';

import '../models/meal.dart';

class CategoriesScreen extends StatefulWidget {
  final String routeName = '/categories';
  final Function toggleFavorite;
  final Function isMealFavorite;
  final Map<String, bool> filters;

  CategoriesScreen(
      this.toggleFavorite, this.isMealFavorite, this.filters);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    List<Meal> _categoryMeals(String catId) => DUMMY_MEALS
        .where(
          (meal) =>
              meal.categories.contains(catId) &&
              ((meal.isGlutenFree && widget.filters['isGlutenFree']) ||
                  !widget.filters['isGlutenFree']) &&
              ((meal.isLactoseFree && widget.filters['isLactoseFree']) ||
                  !widget.filters['isLactoseFree']) &&
              ((meal.isVegan && widget.filters['isVegan']) ||
                  !widget.filters['isVegan']) &&
              ((meal.isVegetarian && widget.filters['isVegetarian']) ||
                  !widget.filters['isVegetarian']),
        )
        .toList();

    return Scaffold(
      body: SafeArea(
        top: false,
        child: GridView(
          padding: const EdgeInsets.all(8),
          children: DUMMY_CATEGORIES
              .map(
                (catData) => CategoryItem(
                  catData.title,
                  catData.color,
                  widget.toggleFavorite,
                  widget.isMealFavorite,
                  widget.filters,
                  _categoryMeals(catData.id),
                ),
              )
              .toList(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
        ),
      ),
    );
  }
}
