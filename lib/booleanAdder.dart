import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'formCreator.dart' as formCreator;
import 'formCreator.dart';

// ignore: must_be_immutable
class BooleanAdderPage extends StatefulWidget {
  String attribute;
  int index;

  BooleanAdderPage({Key key, this.attribute, this.index});

  @override
  BooleanAdderState createState() {
    return BooleanAdderState();
  }
}

class BooleanAdderState extends State<BooleanAdderPage> {
  @override
  Widget build(BuildContext context) {
    var _attributeController =
        new TextEditingController(text: widget.attribute);
    var edit = widget.attribute != null;
    var index = widget.index;
    return Scaffold(
        appBar: AppBar(
          title: Text("Boolean Component"),
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
                          builder: (context) => PreviewBoolean(
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
class PreviewBoolean extends StatefulWidget {
  String attribute;
  bool edit;
  int index;

  PreviewBoolean({Key key, this.attribute, this.edit, this.index});

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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            FormBuilderRadio(
              activeColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(labelText: '${widget.attribute}'),
              attribute: "${widget.attribute}",
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
                if (widget.edit == false) {
                  formCreator.addComponent(
                    Card(
                      child: Container(
                        height: 136,
                        child: FormBuilderRadio(
                          activeColor: Theme.of(context).primaryColor,
                          decoration:
                              InputDecoration(labelText: '${widget.attribute}'),
                          attribute: "${widget.attribute}",
                          initialValue: "Yes",
                          validators: [FormBuilderValidators.required()],
                          options: ["Yes", "No"]
                              .map((lang) => FormBuilderFieldOption(
                                    value: lang,
                                    child: Text('$lang'),
                                  ))
                              .toList(growable: false),
                        ),
                      ),
                      key: ValueKey(widget.attribute),
                    ),
                  );
                  formCreator.addDetails(
                      ["FormBuilderBoolean", "${widget.attribute}"]);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => FormCreatorPage()),
                    ModalRoute.withName('/'),
                  );
                } else {
                  formCreator.editComponent(
                    Card(
                      child: Container(
                        height: 136,
                        child: FormBuilderRadio(
                          activeColor: Theme.of(context).primaryColor,
                          decoration:
                              InputDecoration(labelText: '${widget.attribute}'),
                          attribute: "${widget.attribute}",
                          initialValue: "Yes",
                          validators: [FormBuilderValidators.required()],
                          options: ["Yes", "No"]
                              .map((lang) => FormBuilderFieldOption(
                                    value: lang,
                                    child: Text('$lang'),
                                  ))
                              .toList(growable: false),
                        ),
                      ),
                      key: ValueKey(widget.attribute),
                    ),
                    widget.index,
                  );
                  formCreator.editDetails(
                    ["FormBuilderBoolean", "${widget.attribute}"],
                    widget.index,
                  );
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => FormCreatorPage()),
                    ModalRoute.withName('/'),
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
