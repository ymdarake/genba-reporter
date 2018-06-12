import 'package:flutter/material.dart';


class StockListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("stock screen"),
      ),
      body: new Padding(
        padding: new EdgeInsets.all(16.0),
        child: new Text('stock list'),
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/stock_create');
          },
          child: new Icon(Icons.add,),
      )
    );
  }
}
