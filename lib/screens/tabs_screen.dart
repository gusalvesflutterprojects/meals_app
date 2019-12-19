import 'package:flutter/material.dart';

import './categories_screen.dart';
import './favorite_meals_screen.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentPageIdx = 0;
  List<String> _favorites = ['m2', 'm3', 'm4'];

  void _addFavorite(String mealId) {
    setState(() => _favorites.add(mealId));
  }

  void _removeFavorite(String mealId) {
    setState(
        () => _favorites.removeWhere((favoriteId) => favoriteId == mealId));
  }

  bool _checkFavorite(String mealId) => _favorites.contains(mealId);

  void _selectPage(int newPageIdx) =>
      setState(() => _currentPageIdx = newPageIdx);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> _pages = [
      {
        'title': 'Categories',
        'page': CategoriesScreen(_addFavorite, _removeFavorite, _checkFavorite),
      },
      {
        'title': 'Fucking best meals ever',
        'page': FavoriteMealsScreen(_favorites, _addFavorite, _removeFavorite),
      },
    ];

    return Scaffold(
      body: _pages[_currentPageIdx]['page'],
      appBar: AppBar(title: Text(_pages[_currentPageIdx]['title'])),
      drawer: MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 12,
        type: BottomNavigationBarType.shifting,
        currentIndex: _currentPageIdx,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.black12,
        onTap: (i) => _selectPage(i),
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(
              Icons.category,
            ),
            title: Text(
              'Categories',
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.green,
            icon: Icon(
              Icons.star,
            ),
            title: Text(
              'Favorites',
            ),
          ),
        ],
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }
}
