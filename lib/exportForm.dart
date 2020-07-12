import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'fileUtils.dart';
import 'formCreator.dart';

class StringGenerator {}

// ignore: must_be_immutable
class ExportPage extends StatefulWidget {
  List<List<String>> details;

  ExportPage({Key key, this.details}) : super(key: key);

  @override
  ExportPageState createState() {
    return ExportPageState();
  }
}

class ExportPageState extends State<ExportPage> {
  var _nameController = new TextEditingController();

  static String createString(List<List<String>> detail) {
    String value = "";
    for (List<String> i in detail) {
      value += i.toString() + ";";
    }
    print(value);
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Export Form"),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "File Name"),
              ),
            ),
            RaisedButton(
              child: Text("Export"),
              onPressed: () async {
                await FileUtils.saveToFile(
                    createString(widget.details), _nameController.text);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => FormCreatorPage()),
                  (Route<dynamic> route) => false,
                );
              },
            )
          ],
        ));
  }
}
