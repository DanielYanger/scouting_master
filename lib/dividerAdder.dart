import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'formCreator.dart' as formCreator;
import 'formCreator.dart';

class DividerAdderPage extends StatefulWidget {
  @override
  DividerAdderPageState createState() {
    return DividerAdderPageState();
  }
}

class DividerAdderPageState extends State<DividerAdderPage> {
  var _attributeController = new TextEditingController();
  var _fontSizeController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Divider Component"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text("Label"),
                subtitle: TextField(
                  controller: _attributeController,
                ),
                isThreeLine: true,
              ),
              ListTile(
                title: Text("Font Size"),
                subtitle: TextField(
                  controller: _fontSizeController,
                ),
                isThreeLine: true,
              ),
              ListTile(
                title: RaisedButton(
                  child: Text("Submit"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PreviewDivider(
                                attribute: _attributeController.text,
                                fontSize:
                                    double.parse(_fontSizeController.text),
                              )),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

// ignore: must_be_immutable
class PreviewDivider extends StatefulWidget {
  String attribute;
  double fontSize;

  PreviewDivider({Key key, this.attribute, this.fontSize}) : super(key: key);

  @override
  PreviewDividerState createState() => PreviewDividerState();
}

class PreviewDividerState extends State<PreviewDivider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview Divider"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Card(
              child: Center(
                  child: Text('${widget.attribute}',
                      style: TextStyle(fontSize: widget.fontSize))),
            ),
            RaisedButton(
              child: Text("Confirm"),
              onPressed: () {
                formCreator.addComponent(
                  Center(
                      child: Text('${widget.attribute}',
                          style: TextStyle(fontSize: widget.fontSize))),
                );
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => FormCreatorPage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
