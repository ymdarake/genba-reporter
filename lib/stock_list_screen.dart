import 'package:flutter/material.dart';
import 'model/stock_dao.dart';
import 'model/stock.dart';

class StockListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new StockListState();
}

class StockListState extends State<StockListScreen> {
  final dao = StockDao();
  List<Stock> stocks = [];
  var initialized = false;

  @override
  Widget build(BuildContext context) {
    dao.all().then((res) {
      if (!initialized) {
        initialized = true;
        handleFetched(res);
      }
    });
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("stock screen"),
        ),
        body: new Padding(
          padding: new EdgeInsets.all(16.0),
          child: new ListView(
            children: stocks.map((s) {
              return new Text(s.title);
            }).toList(),
          ),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/stock_create');
          },
          child: new Icon(
            Icons.add,
          ),
        ));
  }

  void handleFetched(res) {
    print("hook called");//NOTE: 複数回呼ばれているくさい?
    setState(() {
      stocks = res;
    });
  }
}
