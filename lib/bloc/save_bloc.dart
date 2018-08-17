import '../api/search_api.dart';
import '../model/stock.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class SearchBLoC {
  final SearchApi api;

  ReplaySubject<String> _query = new ReplaySubject<String>();
  Sink<String> get query => _query;

  Stream<List<Stock>> _results;
  Stream<List<Stock>> get results => _results;

  SearchBLoC(this.api) {
    _results = _query.stream.asyncMap(api.search).asBroadcastStream();
  }

  void dispose() {
    _query.close();
  }

}