import 'dart:async';
import 'dart:io';
import 'dart:convert';
import '../model/stock.dart';
import '../io/files.dart';
import '../util/hasher.dart';

class StockDao {
  Future<File> create(String title, String member, [String detail = '']) async {
    var files = Files();
    return files.createIfNot('8rocket.json').then((_) {
      return all();
    }).then((saved) {
      saved.add(new Stock(Hasher().md5(title + member), title, member, detail));
      var ids = [];
      saved = saved.where((s) {
        var contains = ids.contains(s.id);
        if (!contains) {
          ids.add(s.id);
        }
        return !contains;
      }).toList();
      files.write('8rocket.json', json.encode(saved));
    });
  }

  //TODO: Stockごと引き回したい(気もする)
  Future<File> update(
      String id, String title, String member, String detail) async {
    var files = Files();
    return files.createIfNot('8rocket.json').then((_) {
      return all();
    }).then((saved) {
      saved = saved.map((s) {
        if (s.id != id) return s;
        return new Stock(s.id, title, member, detail);
      }).toList();
      files.write('8rocket.json', json.encode(saved));
    });
  }

  Future<List<Stock>> all() async {
    return Files().read('8rocket.json').then((text) {
      return (json.decode(text) as List).map((e) {
        return Stock.fromJson(e);
      }).toList();
    });
  }

  Future<List<Stock>> find(String title) async {
    return Files().read('8rocket.json').then((text) {
      return (json.decode(text) as List).map((e) {
        return Stock.fromJson(e);
      }).where((s) {
        return s.title.contains(title);
      }).toList();
    });
  }

  Future<File> reset() async {
    return Files().overwrite('8rocket.json', '[]');
  }
}
