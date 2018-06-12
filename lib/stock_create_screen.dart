import 'package:flutter/material.dart';


class StockCreateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MyForm();
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => new _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final myController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    myController.addListener(_save);
  }

  @override
  void dispose() {
    myController.removeListener(_save);
    myController.dispose();
    super.dispose();
  }

  _save() {
    print("Second text field: ${myController.text}");

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
                print(myController.text);
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
}