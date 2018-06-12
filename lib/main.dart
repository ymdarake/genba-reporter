import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'stock_list_screen.dart';
import 'stock_create_screen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      theme: new ThemeData(primaryColor: Colors.yellow),
      home: new HomeScreen(),
      routes: {
        '/stock_list': (context) => new StockListScreen(),
        '/stock_create': (context) => new StockCreateScreen(),
      },
    );
  }
}

//class RandomWords extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() => new RandomWordsState();
//}
//
//class RandomWordsState extends State<RandomWords> {
//
//  final _suggestions = <WordPair>[];
//  final _saved = new Set<WordPair>();
//  final _biggerFont = const TextStyle(fontSize: 18.0);
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text('Startup name generator'),
//        actions: <Widget>[
//          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
//        ],
//      ),
//      body: _buildSuggestions(),
//    );
//  }
//
//
//  Widget _buildSuggestions() {
//    return new ListView.builder(
//        padding: const EdgeInsets.all(16.0),
//        itemBuilder: (context, i) {
//          if (i.isOdd) return new Divider();
//
//          final index = i ~/ 2;
//          if (index >= _suggestions.length) {
//            _suggestions.addAll(generateWordPairs().take(10));
//          }
//          return _buildRow(_suggestions[index]);
//        }
//    );
//  }
//
//  Widget _buildRow(WordPair pair) {
//    final alreadySaved = _saved.contains(pair);
//    final tile = new ListTile(
//      title: new Text(
//        pair.asPascalCase,
//        style: _biggerFont,
//      ),
//      trailing: new Icon(
//        alreadySaved ? Icons.favorite : Icons.favorite_border,
//        color: alreadySaved ? Colors.red : null,
//      ),
//      onTap: () {
//        setState(() {
//          if (alreadySaved) {
//            _saved.remove(pair);
//          } else {
//            _saved.add(pair);
//          }
//        });
//      },
//    );
//    return new Builder(
//        builder: (context) {
//          return
//            new Dismissible(
//              key: new Key(tile.toString()),
//              child: tile,
//              onDismissed: (direction) {
//                _suggestions.remove(tile);
//                Scaffold.of(context).showSnackBar(
//                  new SnackBar(
//                    content: new Text("Deleted!"),
//                    action: new SnackBarAction(
//                      label: "Undo",
//                      onPressed: () {
//                        print("heyheyhey");
//                      },
//                    ),
//                  ),
//                );
//              },
//              background: new Container(color: Colors.amber),
//              direction: DismissDirection.startToEnd,
//            );
//        });
//  }
//}