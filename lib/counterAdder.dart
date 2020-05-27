import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'formCreator.dart' as formCreator;
import 'formCreator.dart';

class CounterAdderPage extends StatefulWidget {
  @override
  CounterAdderPageState createState() {
    return CounterAdderPageState();
  }
}

class CounterAdderPageState extends State<CounterAdderPage> {
  var _attributeController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                  child: Text("Submit"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PreviewCounter(
                                attribute: _attributeController.text,
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

  PreviewCounter({Key key, this.attribute}) : super(key: key);

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
            ),
            RaisedButton(
              child: Text("Confirm"),
              onPressed: () {
                formCreator.addComponent(new FormBuilderTouchSpin(
                  attribute: "${widget.attribute}",
                  initialValue: 0,
                  decoration: InputDecoration(
                    labelText: "${widget.attribute}",
                  ),
                  step: 1,
                ));

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
