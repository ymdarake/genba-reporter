import 'package:flutter/material.dart';


class StockDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("home screen"),
      ),
      body: new Padding(
        padding: new EdgeInsets.all(16.0),
        child: new Text('home'),
      ),
    );
  }
}
