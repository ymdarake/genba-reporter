//import 'package:flutter/material.dart';
//import 'dart:async';
//import 'model/stock_dao.dart';
//import 'model/stock.dart';
//
//class StockListScreen extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() => new StockListState();
//}
//
//class StockListState extends State<StockListScreen> {
//  final businessLogic = SearchBusinessLogic();
//  final searchController = TextEditingController();
//
//  @override
//  void initState() {
//    super.initState();
//    searchController.text = "domo";
//  }
//
//  @override
//  void dispose() {
//    searchController.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text("一覧"),
//      ),
//      body: new Column(
//        mainAxisSize: MainAxisSize.min,
//        children: [
//          new TextField(
//            controller: searchController,
//            onChanged: (input) async {
//              await businessLogic.performSearch(input);
//              setState(() {});
//            },
//          ),
//          new Column(
//              children: businessLogic.results.map(SearchResult.from).toList()),
//        ],
//      ),
//    );
//  }
//}
//
//class SearchBusinessLogic {
//  final SearchApi api = SearchApi();
//  List<Stock> results = [];
//
//  Future<Null> performSearch(String query) async {
//    results = await api.search(query);
//  }
//}
//
//class SearchApi {
//  final StockDao dao = new StockDao();
//
//  Future<List<Stock>> search(String title) async {
//    return dao.find(title);
//  }
//}
//
//class SearchResult {
//  static ListTile from(Stock s) {
//    return new ListTile(
//      title: new Text(
//        s.title,
//      ),
//      trailing: new Icon(
//        Icons.favorite_border,
//        color: null,
//      ),
//    );
//  }
//}
