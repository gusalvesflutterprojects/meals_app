import 'package:flutter/material.dart';

class MainDrawer extends StatefulWidget {
  final Map<String, bool> filters;
  final Function updateFilters;

  MainDrawer(this.filters, this.updateFilters);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  bool _shouldShowFilters = false;
  String _formatTitle(String title) => RegExp(r"[A-Z]\w+")
      .firstMatch(title)
      .group(0)
      .split(RegExp(r"(?=[A-Z])"))
      .join(' ');

  @override
  Widget build(BuildContext context) {
    List<String> _filterNames = widget.filters.keys.toList();
    Widget _buildDrawerItem(
      Icon itemIcon,
      String itemTitle,
      Function onTapHandler,
    ) =>
        Container(
          color: itemTitle == 'Filters' && _shouldShowFilters
              ? Colors.black12
              : null,
          child: ListTile(
            leading: itemIcon,
            title: Text(
              itemTitle,
              style: TextStyle(
                fontFamily: 'Helvetica',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: onTapHandler,
          ),
        );

    Widget _buildSingleFilter(String filterName) {
      return SwitchListTile(
        title: Text(
          _formatTitle(filterName),
          style: TextStyle(fontSize: 16),
        ),
        value: widget.filters[filterName],
        onChanged: (_) => widget.updateFilters(filterName),
        subtitle: Text('Only include ${_formatTitle(filterName)} meals.'),
      );
    }

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
                fontSize: 42,
              ),
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
            'Meals',
            () => Navigator.of(context).pushNamed('/'),
          ),
          _buildDrawerItem(
            Icon(
              Icons.filter_list,
              size: 26,
            ),
            'Filters',
            () => setState(() => _shouldShowFilters = !_shouldShowFilters),
          ),
          _shouldShowFilters
              ? Container(
                  color: Colors.black12,
                  child: Column(
                    children: _filterNames
                        .map((filterName) => _buildSingleFilter(filterName))
                        .toList(),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
