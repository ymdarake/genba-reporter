import 'dart:async';
import '../model/stock.dart';
import '../model/stock_dao.dart';

abstract class SearchApi {
  Future<List<Stock>> search(String title);
}

class SimpleSearchApi extends SearchApi {
  final SqfliteStockDao dao = new SqfliteStockDao();

  Future<List<Stock>> search(String title) async {
    return dao.find(title);
  }
}
