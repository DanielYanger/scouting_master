import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'formCreator.dart' as formCreator;
import 'formCreator.dart';

class CounterAdderPage extends StatefulWidget {
  String attribute;
  int index;
  CounterAdderPage({Key key, this.attribute, this.index});

  @override
  CounterAdderPageState createState() {
    return CounterAdderPageState();
  }
}

class CounterAdderPageState extends State<CounterAdderPage> {
  @override
  Widget build(BuildContext context) {
    var _attributeController =
        new TextEditingController(text: widget.attribute);
    var edit = widget.attribute != null;
    var index = widget.index;
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Counter Component"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text("Field Name"),
                subtitle: TextField(
                  controller: _attributeController,
                ),
                isThreeLine: true,
              ),
              ListTile(
                title: RaisedButton(
                  child: Text("Create"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PreviewCounter(
                                attribute: _attributeController.text,
                                edit: edit,
                                index: index,
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
class PreviewCounter extends StatefulWidget {
  String attribute;
  bool edit;
  int index;

  PreviewCounter({Key key, this.attribute, this.edit, this.index})
      : super(key: key);

  @override
  PreviewCounterState createState() => PreviewCounterState();
}

class PreviewCounterState extends State<PreviewCounter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview Counter Component"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            FormBuilderTouchSpin(
              attribute: "${widget.attribute}",
              initialValue: 0,
              decoration: InputDecoration(
                labelText: "${widget.attribute}",
              ),
              step: 1,
              addIcon: Icon(Icons.add_circle),
              subtractIcon: Icon(Icons.remove_circle),
              iconSize: 48.0,
              min: 0,
            ),
            RaisedButton(
              child: Text("Confirm"),
              onPressed: () {
                if (widget.edit == false) {
                  formCreator.addComponent(Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      child: Container(
                        height: 96,
                        child: new FormBuilderTouchSpin(
                          attribute: "${widget.attribute}",
                          initialValue: 0,
                          decoration: InputDecoration(
                            labelText: "${widget.attribute}",
                          ),
                          step: 1,
                          addIcon: Icon(Icons.add_circle),
                          subtractIcon: Icon(Icons.remove_circle),
                          iconSize: 48.0,
                          min: 0,
                        ),
                      ),
                    ),
                    key: Key(widget.attribute),
                  ));
                  formCreator.addDetails(
                      ["FormBuilderTouchSpin", "${widget.attribute}"]);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => FormCreatorPage()),
                    (Route<dynamic> route) => false,
                  );
                } else {
                  formCreator.editComponent(
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                        child: Container(
                          height: 96,
                          child: new FormBuilderTouchSpin(
                            attribute: "${widget.attribute}",
                            initialValue: 0,
                            decoration: InputDecoration(
                              labelText: "${widget.attribute}",
                            ),
                            step: 1,
                            addIcon: Icon(Icons.add_circle),
                            subtractIcon: Icon(Icons.remove_circle),
                            iconSize: 48.0,
                            min: 0,
                          ),
                        ),
                      ),
                      key: Key(widget.attribute),
                    ),
                    widget.index,
                  );
                  formCreator.editDetails(
                    ["FormBuilderTouchSpin", "${widget.attribute}"],
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
