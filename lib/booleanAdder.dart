import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'formCreator.dart' as formCreator;
import 'formCreator.dart';

class BooleanAdderPage extends StatefulWidget {
  @override
  BooleanAdderState createState() {
    return BooleanAdderState();
  }
}

class BooleanAdderState extends State<BooleanAdderPage> {
  var _attributeController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Boolean Component"),
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
                          builder: (context) => PreviewBoolean(
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
class PreviewBoolean extends StatefulWidget {
  String attribute;

  PreviewBoolean({Key key, this.attribute}) : super(key: key);

  @override
  PreviewBooleanState createState() => PreviewBooleanState();
}

class PreviewBooleanState extends State<PreviewBoolean> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview Boolean Component"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            FormBuilderRadio(
              decoration: InputDecoration(labelText: '${widget.attribute}'),
              attribute: "${widget.attribute}",
              leadingInput: true,
              initialValue: "Yes",
              validators: [FormBuilderValidators.required()],
              options: ["Yes", "No"]
                  .map((lang) => FormBuilderFieldOption(
                        value: lang,
                        child: Text('$lang'),
                      ))
                  .toList(growable: false),
            ),
            RaisedButton(
              child: Text("Confirm"),
              onPressed: () {
                formCreator.addComponent(new FormBuilderRadio(
                  decoration: InputDecoration(labelText: '${widget.attribute}'),
                  attribute: "${widget.attribute}",
                  initialValue: "Yes",
                  leadingInput: true,
                  validators: [FormBuilderValidators.required()],
                  options: ["Yes", "No"]
                      .map((lang) => FormBuilderFieldOption(
                            value: lang,
                            child: Text('$lang'),
                          ))
                      .toList(growable: false),
                ));
                formCreator.addDetails(
                    ["FormBuilderRadio", "${widget.attribute}", "Yes", "No"]);
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
