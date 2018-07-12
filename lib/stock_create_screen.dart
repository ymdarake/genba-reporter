import 'package:flutter/material.dart';
import './component/stock_form.dart';
import 'model/stock.dart';

class StockCreateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StockForm(new Stock('', '', '', ''));
  }
}
