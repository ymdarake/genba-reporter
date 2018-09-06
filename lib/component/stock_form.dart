import 'package:flutter/material.dart';
import '../io/files.dart';
import '../model/stock_dao.dart';
import '../model/stock.dart';

class StockForm extends StatefulWidget {

  Stock stock;
  StockForm(this.stock);

  @override
  StockFormState createState() => new StockFormState(this.stock);
}

class StockFormState extends State<StockForm> {
  final titleController = TextEditingController();
  final memberController = TextEditingController(); //TODO: objectにする
  final detailController = TextEditingController();
  final dao = InMemoryStockDao();

  Stock stock;
  StockFormState(this.stock);

  @override
  void initState() {
    super.initState();
    titleController.text = this.stock.title;
    memberController.text = this.stock.member;
    detailController.text = this.stock.detail;
  }

  @override
  void dispose() {
    titleController.dispose();
    memberController.dispose();
    detailController.dispose();
    super.dispose();
  }

  _save() {
    if (this.stock.id.length > 0) {
      dao.update(this.stock.id, titleController.text, memberController.text, detailController.text);
    } else {
      dao.create(titleController.text, memberController.text, detailController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('作成/編集'),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(
                Icons.check,
                color: Colors.black,
              ),
              onPressed: () {
                _save();
                Navigator.pop(context);
              }),
        ],
      ),
      body: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            new TextField(
              controller: titleController,
              decoration: InputDecoration(hintText: 'タイトルを入力してください'),
            ),
            new TextField(
              controller: memberController,
              decoration: InputDecoration(hintText: 'メンバーを入力してください'),
            ),
            new TextField(
              controller: detailController,
              decoration: InputDecoration(hintText: '詳細を入力してください'),
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }

}
