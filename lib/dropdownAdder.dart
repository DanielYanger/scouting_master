import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'formCreator.dart' as formCreator;
import 'formCreator.dart';

// ignore: must_be_immutable
class DropdownAdderPage extends StatefulWidget {
  String attribute;
  String hint;
  List<String> options;
  int index;

  DropdownAdderPage({
    Key key,
    this.attribute,
    this.options,
    this.index,
    this.hint,
  }) : super(key: key);

  @override
  DropdownAdderPageState createState() {
    return DropdownAdderPageState();
  }
}

class DropdownAdderPageState extends State<DropdownAdderPage> {
  @override
  Widget build(BuildContext context) {
    var _attributeController =
        new TextEditingController(text: widget.attribute);
    var _hintController = new TextEditingController(text: widget.hint);
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
          title: Text("Dropdown Component"),
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
                title: Text("Preview Text"),
                subtitle: TextField(
                  controller: _hintController,
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
                          builder: (context) => PreviewDropdown(
                                attribute: _attributeController.text,
                                values: _optionsController.text,
                                hint: _hintController.text,
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

List<DropdownMenuItem<dynamic>> createSet(List<dynamic> list) {
  List<DropdownMenuItem> result = new List<DropdownMenuItem>();
  print(list);
  result = list
      .map((option) => DropdownMenuItem(
            child: Text('$option'),
            value: option,
          ))
      .toList();
  print(result);
  return result;
}

// ignore: must_be_immutable
class PreviewDropdown extends StatefulWidget {
  String attribute;
  String values;
  String hint;
  int index;
  bool edit;

  PreviewDropdown({
    Key key,
    this.attribute,
    this.values,
    this.hint,
    this.edit,
    this.index,
  }) : super(key: key);

  @override
  PreviewDropdownState createState() => PreviewDropdownState();
}

class PreviewDropdownState extends State<PreviewDropdown> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  static List<String> exporter(
      String attribute, String hint, List<String> values) {
    List<String> finalValue = ["FormBuilderDropdown", attribute, hint];
    for (String i in values) {
      finalValue.add(i);
    }
    return finalValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview Dropdown Component"),
      ),
      body: FormBuilder(
        key: _fbKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              FormBuilderDropdown(
                attribute: "${widget.attribute}",
                decoration: InputDecoration(
                  labelText: "${widget.attribute}",
                ),
                hint: Text('${widget.hint}'),
                validators: [FormBuilderValidators.required()],
                items: createSet(widget.values.split(',')),
              ),
              RaisedButton(
                child: Text("Confirm"),
                onPressed: () {
                  if (!widget.edit) {
                    formCreator.addComponent(
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: 70,
                          child: Card(
                            child: FormBuilderDropdown(
                              attribute: "${widget.attribute}",
                              decoration: InputDecoration(
                                labelText: "${widget.attribute}",
                              ),
                              hint: Text('${widget.hint}'),
                              validators: [FormBuilderValidators.required()],
                              items: createSet(widget.values.split(',')),
                            ),
                          ),
                        ),
                        key: ValueKey(widget.attribute),
                      ),
                    );
                    formCreator.addDetails(exporter(widget.attribute,
                        widget.hint, widget.values.split(",")));
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FormCreatorPage()),
                      (Route<dynamic> route) => false,
                    );
                  } else {
                    formCreator.editComponent(
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: 70,
                          child: Card(
                            child: FormBuilderDropdown(
                              attribute: "${widget.attribute}",
                              decoration: InputDecoration(
                                labelText: "${widget.attribute}",
                              ),
                              hint: Text('${widget.hint}'),
                              validators: [FormBuilderValidators.required()],
                              items: createSet(widget.values.split(',')),
                            ),
                          ),
                        ),
                        key: ValueKey(widget.attribute),
                      ),
                      widget.index,
                    );
                    formCreator.editDetails(
                      exporter(
                        widget.attribute,
                        widget.hint,
                        widget.values.split(","),
                      ),
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
