import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'formCreator.dart' as formCreator;
import 'formCreator.dart';

// ignore: must_be_immutable
class SliderAdderPage extends StatefulWidget {
  String attribute;
  double min;
  double max;
  double initialValue;
  int divisions;
  int index;

  SliderAdderPage({
    Key key,
    this.attribute,
    this.min,
    this.max,
    this.divisions,
    this.initialValue,
    this.index,
  }) : super(key: key);

  @override
  SliderAdderPageState createState() {
    return SliderAdderPageState();
  }
}

class SliderAdderPageState extends State<SliderAdderPage> {
  @override
  Widget build(BuildContext context) {
    bool edit = widget.attribute != null;
    var _attributeController =
        new TextEditingController(text: widget.attribute);
    var _minController = new TextEditingController(
        text: edit ? widget.min.toInt().toString() : null);
    var _maxController = new TextEditingController(
        text: edit ? widget.max.toInt().toString() : null);
    var _initialValueController = new TextEditingController(
        text: edit ? widget.initialValue.toInt().toString() : null);
    var _divisionController = new TextEditingController(
        text: edit ? widget.divisions.toString() : null);

    return Scaffold(
        appBar: AppBar(
          title: Text("Add Slider Component"),
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
                title: Text("Minimum Value"),
                subtitle: TextField(
                  controller: _minController,
                  keyboardType: TextInputType.number,
                ),
                isThreeLine: true,
              ),
              ListTile(
                title: Text("Maximum Value"),
                subtitle: TextField(
                  controller: _maxController,
                  keyboardType: TextInputType.number,
                ),
                isThreeLine: true,
              ),
              ListTile(
                title: Text("Initial Value"),
                subtitle: TextField(
                  controller: _initialValueController,
                  keyboardType: TextInputType.number,
                ),
                isThreeLine: true,
              ),
              ListTile(
                title: Text("Divisions"),
                subtitle: TextField(
                  controller: _divisionController,
                  keyboardType: TextInputType.number,
                ),
                isThreeLine: true,
              ),
              ListTile(
                title: RaisedButton(
                  child: Text("Create"),
                  onPressed: () {
                    if (double.parse(_minController.text) <=
                            double.parse(_initialValueController.text) &&
                        double.parse(_initialValueController.text) <=
                            double.parse(_maxController.text) &&
                        _attributeController != null &&
                        _divisionController.text.indexOf(".") == -1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PreviewSlider(
                                  attribute: _attributeController.text,
                                  min: double.parse(_minController.text),
                                  max: double.parse(_maxController.text),
                                  initial: double.parse(
                                      _initialValueController.text),
                                  divisions:
                                      int.parse(_divisionController.text),
                                  edit: edit,
                                  index: widget.index,
                                )),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Error"),
                            content: const Text(
                                "Please make sure that the numbers are valid."),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text("RETURN"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

// ignore: must_be_immutable
class PreviewSlider extends StatefulWidget {
  String attribute;
  double min;
  double max;
  double initial;
  int divisions;
  int index;
  bool edit;

  PreviewSlider({
    Key key,
    this.attribute,
    this.min,
    this.max,
    this.initial,
    this.divisions,
    this.edit,
    this.index,
  }) : super(key: key);

  @override
  PreviewSliderState createState() => PreviewSliderState();
}

class PreviewSliderState extends State<PreviewSlider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview Slider Component"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            new FormBuilderSlider(
              attribute: "${widget.attribute}",
              min: widget.min,
              max: widget.max,
              initialValue: widget.initial,
              divisions: widget.divisions,
              activeColor: Colors.green,
              inactiveColor: Colors.green[100],
              decoration: InputDecoration(
                labelText: "${widget.attribute}",
                labelStyle: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            RaisedButton(
              child: Text("Confirm"),
              onPressed: () {
                if (!widget.edit) {
                  formCreator.addComponent(Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      child: Container(
                        height: 114,
                        child: new FormBuilderSlider(
                          attribute: "${widget.attribute}",
                          min: widget.min,
                          max: widget.max,
                          initialValue: widget.initial,
                          divisions: widget.divisions,
                          activeColor: Colors.green,
                          inactiveColor: Colors.green[100],
                          decoration: InputDecoration(
                            labelText: "${widget.attribute}",
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    key: ValueKey(widget.attribute),
                  ));
                  formCreator.addDetails([
                    "FormBuilderSlider",
                    "${widget.attribute}",
                    "${widget.min}",
                    "${widget.max}",
                    "${widget.initial}",
                    "${widget.divisions}"
                  ]);
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
                          height: 114,
                          child: new FormBuilderSlider(
                            attribute: "${widget.attribute}",
                            min: widget.min,
                            max: widget.max,
                            initialValue: widget.initial,
                            divisions: widget.divisions,
                            activeColor: Colors.green,
                            inactiveColor: Colors.green[100],
                            decoration: InputDecoration(
                              labelText: "${widget.attribute}",
                              labelStyle:
                              TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      key: ValueKey(widget.attribute),
                    ),
                    widget.index,
                  );
                  formCreator.editDetails(
                    [
                      "FormBuilderSlider",
                      "${widget.attribute}",
                      "${widget.min}",
                      "${widget.max}",
                      "${widget.initial}",
                      "${widget.divisions}"
                    ],
                    widget.index,
                  );
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => FormCreatorPage()),
                    (Route<dynamic> route) => false,
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
