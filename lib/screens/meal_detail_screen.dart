import 'package:flutter/material.dart';

import '../models/meal.dart';

import '../dummy-data.dart';

class MealDetailScreen extends StatefulWidget {
  static const routeName = '/meal-detail';

  @override
  _MealDetailScreenState createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  bool isFavorite;

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    final String mealId = routeArgs['id'];

    final Meal selectedMeal =
        DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    final AppBar appBar = AppBar(
      title: Text(selectedMeal.title),
    );

    void _toggleFavorite() {
      if (isFavorite) {
        setState(() => isFavorite = false);
        routeArgs['removeFavorite'](mealId);
      } else {
        setState(() => isFavorite = true);
        routeArgs['addFavorite'](mealId);
      }
    }

    Widget _buildSectionTitle(String title) => Container(
          margin: EdgeInsets.symmetric(vertical: 12),
          child: Text(
            title,
            style: Theme.of(context).textTheme.title,
          ),
        );
    Widget _buildSectionContent(Widget child) => Container(
          height: 200,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(10)),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.circular(10),
            ),
            child: child,
          ),
        );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(children: <Widget>[
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    .40,
                width: double.infinity,
                child: Image.network(
                  selectedMeal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 24,
                right: 24,
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.star : Icons.star_border,
                    color: Colors.amberAccent,
                    size: 48,
                  ),
                  onPressed: () => _toggleFavorite(),
                ),
              )
            ]),
            _buildSectionTitle('Ingredients'),
            _buildSectionContent(
              ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                itemBuilder: (ctx, i) => Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 12,
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.arrow_right,
                      ),
                      Text(
                        ' ${selectedMeal.ingredients[i]}',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _buildSectionTitle('Steps'),
            _buildSectionContent(ListView.builder(
              itemBuilder: (ctx, i) => Column(
                children: <Widget>[
                  ListTile(
                    // contentPadding: EdgeInsets.all(8),
                    leading: CircleAvatar(
                      child: Text('# ${i + 1}'),
                    ),
                    title: Text('${selectedMeal.steps[i]}'),
                  ),
                  Divider(),
                ],
              ),
              itemCount: selectedMeal.steps.length,
            )),
          ],
        ),
      ),
      appBar: appBar,
    );
  }
}
