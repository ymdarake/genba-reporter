import 'package:flutter/material.dart';
import '../io/files.dart';
import '../model/stock_dao.dart';

class StockForm extends StatefulWidget {
  @override
  StockFormState createState() => new StockFormState();
}

class StockFormState extends State<StockForm> {
  final titleController = TextEditingController();
  final memberController = TextEditingController(); //TODO: objectにする
  final dao = StockDao();

//  @override
//  void initState() {
//    myController.addListenerするならここ
//    super.initState();
//  }

  @override
  void dispose() {
    titleController.dispose();
    memberController.dispose();
    super.dispose();
  }

  _save() {
    dao.create(titleController.text, memberController.text);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Create stock!'),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(
                Icons.check,
                color: Colors.black,
              ),
              onPressed: () {
                _save();
              }),
          new IconButton(
              icon: new Icon(
                Icons.book,
                color: Colors.black,
              ),
              onPressed: () {
                Files().read('8rocket.json').then((t){print(t);});
              })
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
          ],
          //TODO: other fields
        ),
      ),
    );
  }



}
