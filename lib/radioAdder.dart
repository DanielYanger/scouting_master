import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'formCreator.dart' as formCreator;
import 'formCreator.dart';

// ignore: must_be_immutable
class RadioAdderPage extends StatefulWidget {
  String attribute;
  List<String> options;
  int index;

  RadioAdderPage({
    Key key,
    this.attribute,
    this.options,
    this.index,
  }) : super(key: key);

  @override
  RadioAdderPageState createState() {
    return RadioAdderPageState();
  }
}

class RadioAdderPageState extends State<RadioAdderPage> {
  @override
  Widget build(BuildContext context) {
    var _attributeController =
        new TextEditingController(text: widget.attribute);
    bool edit = widget.attribute != null;
    String listOptions = "";
    if (edit) {
      for (String i in widget.options) {
        listOptions += i + ",";
      }
      listOptions = listOptions.substring(0, listOptions.length - 1);
    }
    var _optionsController = new TextEditingController(text: listOptions);
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Radio Component"),
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
                          builder: (context) => PreviewRadio(
                                attribute: _attributeController.text,
                                values: _optionsController.text.split(","),
                                index: widget.index,
                                edit: edit,
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
class PreviewRadio extends StatefulWidget {
  String attribute;
  List<String> values;
  int index;
  bool edit;

  PreviewRadio({
    Key key,
    this.attribute,
    this.values,
    this.index,
    this.edit,
  }) : super(key: key);

  @override
  PreviewRadioState createState() => PreviewRadioState();
}

class PreviewRadioState extends State<PreviewRadio> {
  static List<String> exporter(String attribute, List<String> values) {
    List<String> finalValue = ["FormBuilderRadio", attribute];
    for (String i in values) {
      finalValue.add(i);
    }
    return finalValue;
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Preview Radio Component"),
      ),
      body: FormBuilder(
        key: _fbKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              FormBuilderRadio(
                activeColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  labelText: '${widget.attribute}',
                  labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                ),
                attribute: "${widget.attribute}",
                leadingInput: true,
                validators: [FormBuilderValidators.required()],
                options: createSet(widget.values),
              ),
              RaisedButton(
                child: Text("Confirm"),
                onPressed: () {
                  if (!widget.edit) {
                    formCreator.addComponent(Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Card(
                        child: Container(
                          height: 40.0 + 48.0 * widget.values.length,
                          child: new FormBuilderRadio(
                            activeColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                              labelText: '${widget.attribute}',
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            attribute: "${widget.attribute}",
                            leadingInput: true,
                            validators: [FormBuilderValidators.required()],
                            options: createSet(widget.values),
                          ),
                        ),
                      ),
                      key: ValueKey(widget.attribute),
                    ));
                    formCreator
                        .addDetails(exporter(widget.attribute, widget.values));
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FormCreatorPage()),
                      (Route<dynamic> route) => false,
                    );
                  } else {
                    formCreator.editComponent(
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Card(
                          child: Container(
                            height: 40.0 + 48.0 * widget.values.length,
                            child: new FormBuilderRadio(
                              activeColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                labelText: '${widget.attribute}',
                                labelStyle: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                              attribute: "${widget.attribute}",
                              leadingInput: true,
                              validators: [FormBuilderValidators.required()],
                              options: createSet(widget.values),
                            ),
                          ),
                        ),
                        key: ValueKey(widget.attribute),
                      ),
                      widget.index,
                    );
                    formCreator.editDetails(
                      exporter(widget.attribute, widget.values),
                      widget.index,
                    );
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FormCreatorPage()),
                      (Route<dynamic> route) => false,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
