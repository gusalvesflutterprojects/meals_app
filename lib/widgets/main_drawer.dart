import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerItem(Icon itemIcon, String itemTitle) => ListTile(
          leading: itemIcon,
          title: Text(
            itemTitle,
            style: TextStyle(
                fontFamily: 'Helvetica',
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        );

    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              "Now we're cookin",
              style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor,
                  fontSize: 42),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _buildDrawerItem(
              Icon(
                Icons.restaurant,
                size: 26,
              ),
              'Meals'),
          _buildDrawerItem(
              Icon(
                Icons.restaurant,
                size: 26,
              ),
              'Settings')
        ],
      ),
    );
  }
}
