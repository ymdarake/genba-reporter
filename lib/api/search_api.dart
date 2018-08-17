import 'dart:async';
import '../model/stock.dart';
import '../model/stock_dao.dart';

abstract class SearchApi {
  Future<List<Stock>> search(String title);
}

class SimpleSearchApi extends SearchApi {
  final StockDao dao = new StockDao();

  Future<List<Stock>> search(String title) async {
    return dao.find(title);
  }
}
