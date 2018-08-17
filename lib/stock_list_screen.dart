import 'package:flutter/material.dart';
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
    searchController.text = "domo";
  }

  @override
  void dispose() {
    searchController.dispose();
    businessLogic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("一覧"),
      ),
      body: new Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          new TextField(
            controller: searchController,
            onChanged: businessLogic.query.add,
          ),
          new StreamBuilder(
            stream: businessLogic.results,
            builder: (context, snapshot) => new Column(
                children: (snapshot.data as List<Stock> ?? [])
                    .map(SearchResult.from)
                    .toList()),
          ),
        ],
      ),
    );
  }
}

class SearchResult {
  static ListTile from(Stock s) {
    return new ListTile(
      title: new Text(
        s.title,
      ),
      trailing: new Icon(
        Icons.favorite_border,
        color: null,
      ),
    );
  }
}
