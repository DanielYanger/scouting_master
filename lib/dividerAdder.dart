import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'formCreator.dart' as formCreator;
import 'formCreator.dart';

// ignore: must_be_immutable
class DividerAdderPage extends StatefulWidget {
  String attribute;
  double fontSize;
  int index;

  DividerAdderPage({Key key, this.attribute, this.fontSize, this.index});

  @override
  DividerAdderPageState createState() {
    return DividerAdderPageState();
  }
}

class DividerAdderPageState extends State<DividerAdderPage> {
  @override
  Widget build(BuildContext context) {
    String fontSize =
        widget.fontSize != null ? widget.fontSize.toString() : null;
    var _attributeController =
        new TextEditingController(text: widget.attribute);
    var _fontSizeController = new TextEditingController(text: fontSize);
    var edit = widget.attribute != null;
    return Scaffold(
      appBar: AppBar(
        title: Text("Divider Component"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
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
                keyboardType: TextInputType.number,
              ),
              isThreeLine: true,
            ),
            ListTile(
              title: RaisedButton(
                child: Text("Create"),
                onPressed: () {
                  if (!double.parse(_fontSizeController.text).isNaN) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PreviewDivider(
                          attribute: _attributeController.text,
                          fontSize: double.parse(_fontSizeController.text),
                          index: widget.index,
                          edit: edit,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class PreviewDivider extends StatefulWidget {
  String attribute;
  double fontSize;
  bool edit;
  int index;

  PreviewDivider(
      {Key key, this.attribute, this.fontSize, this.edit, this.index})
      : super(key: key);

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
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Text(
                    '${widget.attribute}',
                    style: TextStyle(
                      fontSize: widget.fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            RaisedButton(
              child: Text("Confirm"),
              onPressed: () {
                if (!widget.edit) {
                  formCreator.addComponent(
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 30 + widget.fontSize,
                        child: Card(
                          child: Center(
                            child: Text(
                              '${widget.attribute}',
                              style: TextStyle(
                                fontSize: widget.fontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        key: ValueKey(widget.attribute),
                      ),
                    ),
                  );
                  formCreator.addDetails([
                    "Divider",
                    "${widget.attribute}",
                    widget.fontSize.toString()
                  ]);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => FormCreatorPage()),
                    (Route<dynamic> route) => false,
                  );
                } else {
                  formCreator.editComponent(
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 30 + widget.fontSize,
                        child: Card(
                          child: Center(
                            child: Text(
                              '${widget.attribute}',
                              style: TextStyle(
                                fontSize: widget.fontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        key: ValueKey(widget.attribute),
                      ),
                    ),
                    widget.index,
                  );
                  formCreator.editDetails(
                    [
                      "Divider",
                      "${widget.attribute}",
                      widget.fontSize.toString()
                    ],
                    widget.index,
                  );
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => FormCreatorPage()),
                    (Route<dynamic> route) => false,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
