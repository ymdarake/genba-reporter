import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

class StockCreateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MyForm();
  }
}

class Stock {
  String title;
  String member;

  Stock(this.title, this.member);

  Map<String, dynamic> toJson() => {
        'title': title,
        'member': member,
      };

  Stock.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        member = json['member'];
}

//TODO: Widgetを分離する
class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => new _MyFormState();
}

class _MyFormState extends State<MyForm> {
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
                read();
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

  //TODO: writerを分離する
  //TODO: Stockオブジェクトをシリアライズ/デシリアライズしてwrite/read
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return new File('$path/8rocke.txt');
  }

  Future<File> write() async {
    final file = await _localFile;
    return _localFile.then((f) {
      f.exists().then((e) {
        if (!e) {
          f.create();
        }
        read().then((text) {
          if (text == "") {
            text = "[]";
          }
          var decoded = json.decode(text);
          return (decoded as List).map((e) {
            return Stock.fromJson(e);
          }).toList();
        }).then((saved) {
          saved.add(new Stock(titleController.text, memberController.text));
          file.writeAsString(json.encode(saved), mode: FileMode.write);
        });
      });
    });
  }

  Future<String> read() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      print('read: ' + contents);
      return contents;
    } catch (e) {
      return "nothing!!!";
    }
  }
}
