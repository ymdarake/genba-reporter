import 'package:flutter/material.dart';
import 'model/stock_dao.dart';
import 'model/stock.dart';
import 'stock_detail_screen.dart';

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
          title: new Text("一覧"),
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.clear_all), onPressed: (){
              dao.reset().then((res){handleAllCleared();});
            })
          ],
        ),
        body: new Padding(
          padding: new EdgeInsets.all(16.0),
          child: new ListView(
            children: stocks.map((s) {
              return new ListTile(
                title: new Text(
                  s.title,
                ),
                trailing: new Icon(
                  Icons.favorite_border,
                  color: null,
                ),
                onTap: () {
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (context) {
                        return new StockDetailScreen(s);
                      }
                  )).then((_){
                    dao.all().then((res){
                      handleFetched(res);
                    });
                  });
                },
              );
            }).toList(),
          ),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/stock_create').then((_) {
              dao.all().then((res) {
                handleFetched(res);
              });
            });
          },
          child: new Icon(
            Icons.add,
          ),
        ));
  }

  void handleFetched(res) {
    setState(() {
      stocks = res;
    });
  }

  void handleAllCleared() {
    setState(() {
      stocks = [];
    });
  }
}
