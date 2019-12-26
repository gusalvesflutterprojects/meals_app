import 'package:flutter/material.dart';

import '../models/meal.dart';

import '../dummy-data.dart';

class MealDetailScreen extends StatefulWidget {
  static const routeName = '/meal-detail';

  @override
  _MealDetailScreenState createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  bool _isFavorite;

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    final String mealId = routeArgs['id'];

    _isFavorite = routeArgs['isMealFavorite'](mealId);

    final Meal selectedMeal =
        DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    final AppBar appBar = AppBar(
      title: Text(selectedMeal.title),
    );

    void _toggleFavorite() {
      setState(() => _isFavorite = !_isFavorite);
      setState(() => routeArgs['toggleFavorite'](mealId));
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
      floatingActionButton: FloatingActionButton(
        child: _isFavorite ? Icon(Icons.star) : Icon(Icons.star_border),
        onPressed: _toggleFavorite,
      ),
      appBar: appBar,
    );
  }
}
