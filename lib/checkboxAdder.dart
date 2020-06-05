import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'formCreator.dart' as formCreator;
import 'formCreator.dart';

class CheckboxAdderPage extends StatefulWidget {
  @override
  CheckboxAdderPageState createState() {
    return CheckboxAdderPageState();
  }
}

class CheckboxAdderPageState extends State<CheckboxAdderPage> {
  var _attributeController = new TextEditingController();
  var _optionsController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Checkbox Component"),
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
                title: Text("Options: Separate with commas"),
                subtitle: TextField(
                  controller: _optionsController,
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
                          builder: (context) => PreviewCheckbox(
                                attribute: _attributeController.text,
                                values: _optionsController.text.split(","),
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

List<FormBuilderFieldOption> createSet(List<String> list) {
  List<FormBuilderFieldOption> result = [];
  for (String i in list) {
    result.add(FormBuilderFieldOption(
      value: i,
    ));
  }
  return result;
}

// ignore: must_be_immutable
class PreviewCheckbox extends StatefulWidget {
  String attribute;
  List<String> values;

  PreviewCheckbox({Key key, this.attribute, this.values}) : super(key: key);

  @override
  PreviewCheckboxState createState() => PreviewCheckboxState();
}

class PreviewCheckboxState extends State<PreviewCheckbox> {
  static List<String> exporter(String attribute, List<String> values) {
    List<String> finalValue = ["FormBuilderCheckboxList", attribute];
    for (String i in values) {
      finalValue.add(i);
    }
    return finalValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview Checkbox Component"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            FormBuilderCheckboxList(
              decoration: InputDecoration(labelText: '${widget.attribute}'),
              attribute: "${widget.attribute}",
              options: createSet(widget.values),
              initialValue: [],
            ),
            RaisedButton(
              child: Text("Confirm"),
              onPressed: () {
                formCreator.addComponent(Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    child: Container(
                      height: 40.0 + 48.0 * widget.values.length,
                      child: new FormBuilderCheckboxList(
                        decoration:
                            InputDecoration(labelText: '${widget.attribute}'),
                        attribute: "${widget.attribute}",
                        options: createSet(widget.values),
                        initialValue: [],
                      ),
                    ),
                  ),
                  key: Key(widget.attribute),
                ));
                formCreator
                    .addDetails(exporter(widget.attribute, widget.values));
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
