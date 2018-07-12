import 'package:flutter/material.dart';
import 'model/stock.dart';
import 'component/stock_form.dart';

class StockDetailScreen extends StatefulWidget {

  Stock stock;
  StockDetailScreen(this.stock);

  @override
  State<StatefulWidget> createState() => new StockDetailScreenState(this.stock);
}

class StockDetailScreenState extends State<StockDetailScreen> {

  Stock stock;
  StockDetailScreenState(this.stock);

  @override
  Widget build(BuildContext context) => new StockForm(this.stock);
}
