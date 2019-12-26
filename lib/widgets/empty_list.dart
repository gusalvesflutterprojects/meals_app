import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      width: 400,
      child: Column(
        children: <Widget>[
          Image.network(
            'https://cdn.icon-icons.com/icons2/1865/PNG/512/cucumber_119597.png',
            fit: BoxFit.fill,
            height: 400,
          ),
          Text('asiopdnasondfopi')
        ],
      ),
    );
  }
}
