import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'formCreator.dart' as formCreator;
import 'formCreator.dart';

class TextboxAdderPage extends StatefulWidget {
  @override
  TextboxAdderPageState createState() {
    return TextboxAdderPageState();
  }
}

class TextboxAdderPageState extends State<TextboxAdderPage> {
  var _attributeController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Textbox Component"),
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
                title: RaisedButton(
                  child: Text("Submit"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PreviewTextbox(
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
class PreviewTextbox extends StatefulWidget {
  String attribute;

  PreviewTextbox({Key key, this.attribute}) : super(key: key);

  @override
  PreviewTextboxState createState() => PreviewTextboxState();
}

class PreviewTextboxState extends State<PreviewTextbox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview Textbox"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            FormBuilderTextField(
              attribute: "${widget.attribute}",
              decoration: InputDecoration(
                labelText: "${widget.attribute}",
              ),
              initialValue: "",
            ),
            RaisedButton(
              child: Text("Confirm"),
              onPressed: () {
                formCreator.addComponent(
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormBuilderTextField(
                        attribute: "${widget.attribute}",
                        decoration: InputDecoration(
                          labelText: "${widget.attribute}",
                        ),
                        initialValue: "",
                      ),
                    ),
                    key: Key(widget.attribute),
                  ),
                );
                List<String> a = [
                  "FormBuilderTextField",
                  "${widget.attribute}"
                ];
                formCreator.addDetails(a);
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
