import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'formCreator.dart' as formCreator;
import 'formCreator.dart';

// ignore: must_be_immutable
class TextboxAdderPage extends StatefulWidget {
  String attribute;
  int index;

  TextboxAdderPage({Key key, this.attribute, this.index});

  @override
  TextboxAdderPageState createState() {
    return TextboxAdderPageState();
  }
}

class TextboxAdderPageState extends State<TextboxAdderPage> {
  @override
  Widget build(BuildContext context) {
    var _attributeController =
        new TextEditingController(text: widget.attribute);
    return Scaffold(
        appBar: AppBar(
          title: Text("Textbox Component"),
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
                  child: Text("Create"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PreviewTextbox(
                          attribute: _attributeController.text,
                          edit: widget.attribute != null,
                          index: widget.index,
                        ),
                      ),
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
  int index;
  bool edit;

  PreviewTextbox({Key key, this.attribute, this.index, this.edit})
      : super(key: key);

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
              readOnly: true,
            ),
            RaisedButton(
              child: Text("Confirm"),
              onPressed: () {
                if (!widget.edit) {
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
                          readOnly: true,
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
                } else {
                  formCreator.editComponent(
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FormBuilderTextField(
                          attribute: "${widget.attribute}",
                          decoration: InputDecoration(
                            labelText: "${widget.attribute}",
                          ),
                          initialValue: "",
                          readOnly: true,
                        ),
                      ),
                      key: Key(widget.attribute),
                    ),
                    widget.index,
                  );
                  formCreator.editDetails(
                    ["FormBuilderTextField", "${widget.attribute}"],
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
