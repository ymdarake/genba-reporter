import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("ホーム"),
      ),
      body: new Padding(
        padding: new EdgeInsets.all(16.0),
        child: new RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/stock_list");
            },
            child: new Text('一覧へ')),
      ),
    );
  }
}
