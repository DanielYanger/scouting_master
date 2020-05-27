import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'formCreator.dart' as formCreator;
import 'formCreator.dart';

class DropdownAdderPage extends StatefulWidget {
  @override
  DropdownAdderPageState createState() {
    return DropdownAdderPageState();
  }
}

class DropdownAdderPageState extends State<DropdownAdderPage> {
  var _attributeController = new TextEditingController();
  var _optionsController = new TextEditingController();
  var _hintController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Dropdown Component"),
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
                title: Text("Options: Seperate with commas"),
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
                  child: Text("Submit"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PreviewDropdown(
                                attribute: _attributeController.text,
                                values: _optionsController.text,
                                hint: _hintController.text,
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

  PreviewDropdown({Key key, this.attribute, this.values, this.hint})
      : super(key: key);

  @override
  PreviewDropdownState createState() => PreviewDropdownState();
}

class PreviewDropdownState extends State<PreviewDropdown> {
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;

  var climbOptions = [
    'Did not Park or Climb',
    'Parked',
    'Solo Climbed',
    'Climbed First',
    'Climbed Second',
    'Buddy Climb',
    'Carried'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview Dropdown Component"),
      ),
      body: Padding(
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
              initialValue: widget.values.split(',')[0],
            ),
            RaisedButton(
              child: Text("Confirm"),
              onPressed: () {
                formCreator.addComponent(
                  new FormBuilderDropdown(
                    attribute: "${widget.attribute}",
                    decoration: InputDecoration(
                      labelText: "${widget.attribute}",
                    ),
                    hint: Text('Climb Option'),
                    validators: [FormBuilderValidators.required()],
                    items: createSet(widget.values.split(',')),
                    initialValue: widget.values.split(',')[0],
                  ),
                );
                formCreator.addDetails([
                  "FormBuilderDropdown",
                  "${widget.attribute}",
                  widget.values.split(',').toString()
                ]);
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
