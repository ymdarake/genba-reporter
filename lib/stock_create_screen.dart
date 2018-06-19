import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class StockCreateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MyForm();
  }
}


//TODO: Widgetを分離する
class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => new _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final myController = new TextEditingController();

//  @override
//  void initState() {
//    myController.addListenerするならここ
//    super.initState();
//  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  _save() {
    print("Second text field: ${myController.text}");
    print("now saving...");
    write();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Create stock!'),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.check, color: Colors.black,),
              onPressed: () {
                _save();
              }),
          new IconButton(
              icon: new Icon(Icons.book, color: Colors.black,),
              onPressed: () {
                read();
              })
        ],
      ),
      body: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            new TextField(
              controller: myController,
            ),
          ],
          //TODO: other fields
        ),
      ),
    );
  }

  //TODO: writerを分離する
  //TODO: Stockオブジェクトをシリアライズ/デシリアライズしてwrite/read
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<File> get _localFile async {
    final path = await _localPath;
    return new File('$path/stock.txt');
  }
  Future<File> write() async {
    final file = await _localFile;
    return file.writeAsString(myController.text, mode: FileMode.append);
  }
  Future<String> read() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      print(contents);
      return contents;
    } catch (e) {
      return "nothing!!!";
    }
  }

}