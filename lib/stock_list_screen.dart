import 'package:flutter/material.dart';
import 'stock_detail_screen.dart';
import 'stock_create_screen.dart';
import 'bloc/search_bloc.dart';
import 'api/search_api.dart';
import 'model/stock.dart';

class StockListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new StockListState();
}

class StockListState extends State<StockListScreen> {
  final businessLogic = new SearchBLoC(new SimpleSearchApi());
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.text = "";
    refreshList(null);
  }

  @override
  void dispose() {
    searchController.dispose();
    businessLogic.dispose();
    super.dispose();
  }

  void refreshList(resolved) {
    businessLogic.query.add("");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("一覧"),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.push(context, new MaterialPageRoute(builder: (ctx) {
            return new StockCreateScreen();
          })).then(refreshList);
        },
        child: new Icon(Icons.add),
      ),
      body: new Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          new TextField(
            controller: searchController,
            decoration: InputDecoration(hintText: 'type to search...'),
            onChanged: businessLogic.query.add,
          ),
          new StreamBuilder(
            stream: businessLogic.results,
            builder: (ctx, snapshot) {
              return new Column(
                  children: (snapshot.data as List<Stock> ?? []).map((s) {
                return SearchResult.from(ctx, s, refreshList);
              }).toList());
            },
          ),
        ],
      ),
    );
  }
}

class SearchResult {
  static ListTile from(context, Stock s, refreshList) {
    return new ListTile(
      title: new Text(
        s.title,
      ),
      trailing: new Icon(
        Icons.favorite_border,
        color: null,
      ),
      onTap: () {
        Navigator.push(context, new MaterialPageRoute(builder: (_) {
          return new StockDetailScreen(s);
        })).then(refreshList);
      },
    );
  }
}
