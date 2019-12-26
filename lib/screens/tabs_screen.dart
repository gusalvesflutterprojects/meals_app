import 'dart:convert';
import 'dart:io';

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
  Map<String, bool> _filters = {
    'isGlutenFree': false,
    'isLactoseFree': false,
    'isVegan': false,
    'isVegetarian': false,
  };

  @override
  Widget build(BuildContext context) {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) {
      final isValidHost = host == "api.my_app";
      return isValidHost;
    });

    void _toggleFavorite(String mealId) {
      int existingIndex =
          _favorites.indexWhere((favoriteMealId) => favoriteMealId == mealId);

      if (existingIndex >= 0)
        setState(() => _favorites.removeAt(existingIndex));
      else
        setState(() => _favorites.add(mealId));
    }

    bool _isMealFavorite(String mealId) => _favorites.contains(mealId);

    void _selectPage(int newPageIdx) =>
        setState(() => _currentPageIdx = newPageIdx);

    void _updateFilters(String filterName) {
      setState(
        () => _filters.update(filterName, (_) => !_filters[filterName]),
      );
    }

    List<Map<String, dynamic>> _pages = [
      {
        'title': 'Categories',
        'page': CategoriesScreen(
          _toggleFavorite,
          _isMealFavorite,
          _filters,
        ),
      },
      {
        'title': 'Fucking best meals ever',
        'page': FavoriteMealsScreen(
          _favorites,
          _toggleFavorite,
          _isMealFavorite,
        ),
      },
    ];

    return Scaffold(
      body: _pages[_currentPageIdx]['page'],
      appBar: AppBar(title: Text(_pages[_currentPageIdx]['title'])),
      drawer: MainDrawer(_filters, _updateFilters),
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
