import 'dart:async';
import 'dart:io';
import 'dart:convert';
import '../model/stock.dart';
import '../io/files.dart';

class StockDao {

  Future<File> create(String title, String member) async {
    var files = Files();
    return files.createIfNot('8rocket.json').then((_) {
      return files.read('8rocket.json');
    }).then((text) {
      if (text == "") {
        text = "[]";
      }
      var decoded = json.decode(text);
      return (decoded as List).map((e) {
        return Stock.fromJson(e);
      }).toList();
    }).then((saved) {
      saved.add(new Stock(title, member));
      files.write('8rocket.json', json.encode(saved));
    });
  }

}