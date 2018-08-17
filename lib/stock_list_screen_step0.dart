//import 'package:flutter/material.dart';
//import 'model/stock_dao.dart';
//import 'model/stock.dart';
//import 'stock_detail_screen.dart';
//
//class StockListScreen extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() => new StockListState();
//}
//
//class StockListState extends State<StockListScreen> {
//  final dao = StockDao();
//  List<Stock> stocks = [];
//  var initialized = false;
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
//    dao.all().then((res) {
//      if (!initialized) {
//        initialized = true;
//        handleFetched(res);
//      }
//    });
//    return new Scaffold(
//        appBar: new AppBar(
//          title: new Text("一覧"),
//          actions: <Widget>[
//            new IconButton(
//                icon: new Icon(Icons.clear_all),
//                onPressed: () {
//                  dao.reset().then((res) {
//                    handleAllCleared();
//                  });
//                }),
//            new IconButton(
//                icon: new Icon(Icons.search),
//                onPressed: () {
//                  _performSearch();
//                })
//          ],
//        ),
//        body: new Column(
//          mainAxisSize: MainAxisSize.min,
//          children: [
//            new TextField(
//              controller: searchController,
//              decoration: InputDecoration(hintText: 'タイトルを入力してください'),
//              onChanged: (input){
//                print(input);
//              },
//            ),
//            new Column(
//                children: stocks.map((s) {
//              return new ListTile(
//                title: new Text(
//                  s.title,
//                ),
//                trailing: new Icon(
//                  Icons.favorite_border,
//                  color: null,
//                ),
//                onTap: () {
//                  Navigator.push(context,
//                      new MaterialPageRoute(builder: (context) {
//                    return new StockDetailScreen(s);
//                  })).then((_) {
//                    dao.all().then((res) {
//                      handleFetched(res);
//                    });
//                  });
//                },
//              );
//            }).toList()),
//          ],
//        ),
//        floatingActionButton: new FloatingActionButton(
//          onPressed: () {
//            Navigator.pushNamed(context, '/stock_create').then((_) {
//              dao.all().then((res) {
//                handleFetched(res);
//              });
//            });
//          },
//          child: new Icon(
//            Icons.add,
//          ),
//        ));
//  }
//
//  void handleFetched(res) {
//    setState(() {
//      stocks = res;
//    });
//  }
//
//  void handleAllCleared() {
//    setState(() {
//      stocks = [];
//    });
//  }
//
//  void _performSearch() {
//    dao.find(searchController.text).then((res) {
//      setState((){
//        stocks = res;
//      });
//    });
//  }
//}
