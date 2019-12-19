import 'package:flutter/material.dart';

import '../dummy-data.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatefulWidget {
  final String routeName = '/categories';
  final Function addFavorite;
  final Function removeFavorite;
  final Function checkFavorite;

  CategoriesScreen(this.addFavorite, this.removeFavorite, this.checkFavorite);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          top: false,
          child: GridView(
            padding: const EdgeInsets.all(8),
            children: DUMMY_CATEGORIES
                .map(
                  (catData) => CategoryItem(
                    catData.id,
                    catData.title,
                    catData.color,
                    widget.addFavorite,
                    widget.removeFavorite,
                    widget.checkFavorite,
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
