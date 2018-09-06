import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart';
import '../model/stock.dart';
import '../io/files.dart';
import '../util/hasher.dart';
import 'package:sqflite/sqflite.dart';


//class StockDao {
//  Future<File> create(String title, String member, [String detail = '']) async {
//    var files = Files();
//    return files.createIfNot('8rocket.json').then((_) {
//      return all();
//    }).then((saved) {
//      saved.add(new Stock(Hasher().md5(title + member), title, member, detail));
//      var ids = [];
//      saved = saved.where((s) {
//        var contains = ids.contains(s.id);
//        if (!contains) {
//          ids.add(s.id);
//        }
//        return !contains;
//      }).toList();
//      files.write('8rocket.json', json.encode(saved));
//    });
//  }
//
//  //TODO: Stockごと引き回したい(気もする)
//  Future<File> update(
//      String id, String title, String member, String detail) async {
//    var files = Files();
//    return files.createIfNot('8rocket.json').then((_) {
//      return all();
//    }).then((saved) {
//      saved = saved.map((s) {
//        if (s.id != id) return s;
//        return new Stock(s.id, title, member, detail);
//      }).toList();
//      files.write('8rocket.json', json.encode(saved));
//    });
//  }
//
//  Future<List<Stock>> all() async {
//    return Files().read('8rocket.json').then((text) {
//      return (json.decode(text) as List).map((e) {
//        return Stock.fromJson(e);
//      }).toList();
//    });
//  }
//
//  Future<List<Stock>> find(String title) async {
//    return Files().read('8rocket.json').then((text) {
//      return (json.decode(text) as List).map((e) {
//        return Stock.fromJson(e);
//      }).where((s) {
//        return s.title.contains(title);
//      }).toList();
//    });
//  }
//
//  Future<File> reset() async {
//    return Files().overwrite('8rocket.json', '[]');
//  }
//}
//
//class InMemoryStockDao {
//  static List<Stock> list = [];
//
//  Future<Null> create(String title, String member, [String detail = '']) async {
//    list.add(Stock(Hasher().md5(title + member), title, member, detail));
//  }
//
//  Future<Null> update(String id, String title, String member, String detail) async {
//      list = list.map((s) {
//        if (s.id != id) return s;
//        return new Stock(s.id, title, member, detail);
//      }).toList();
//  }
//
//  Future<List<Stock>> all() async {
//    return list;
//  }
//
//  Future<List<Stock>> find(String title) async {
//    return list.where((s) {
//      return s.title.contains(title);
//    }).toList();
//  }
//
//  Future<Null> reset() async {
//    list = [];
//  }
//}

class SqfliteStockDao {

  static Database database = null;

  Future<String> getPath() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "genba-reporter.db");
    return path;
  }

  /// @return id
  Future<int> create(String title, String member, [String detail = '']) async {
    if (database == null) {
      var path = await getPath();
      database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
            // When creating the db, create the table
            await db.execute(
                "CREATE TABLE stock(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, member TEXT, detail TEXT)");
          });
    }
    return await database.rawInsert('INSERT INTO stock(title, member, detail) VALUES(?, ?, ?)', [title, member, detail]);
  }

  Future<int> update(int id, String title, String member, String detail) async {
    return await database.rawUpdate(
        'UPDATE stock SET title = ?, member = ? detail = ? WHERE id = ?',
        [title, member, detail, id]);
  }

  Future<List<Stock>> all() async {
    List<Map> list = await database.rawQuery('SELECT * FROM stock');
    print(list);
    return list.map((stock) {
      return Stock.fromJson(stock);
    }).toList();
  }

  Future<List<Stock>> find(String title) async {
    if (title == "") {
      return this.all();
    }
    List<Map> list = await database.rawQuery('SELECT * FROM stock WHERE title LIKE ?', [title]);
    return list.map((s) {
      return Stock.fromJson(s);
    }).toList();
  }

  Future<int> reset() async {
    return await database.rawDelete('DELETE FROM stock');
  }
}
