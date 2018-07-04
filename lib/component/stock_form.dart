import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import '../model/stock.dart';
import '../io/files.dart';

class StockForm extends StatefulWidget {
  @override
  StockFormState createState() => new StockFormState();
}

class StockFormState extends State<StockForm> {
  final titleController = TextEditingController();
  final memberController = TextEditingController(); //TODO: objectにする

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
    write();
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

  Future<File> write() async {
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
      saved.add(new Stock(titleController.text, memberController.text));
      files.write('8rocket.json', json.encode(saved));
    });
  }

}
