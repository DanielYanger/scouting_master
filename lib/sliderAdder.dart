import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'formCreator.dart' as formCreator;
import 'formCreator.dart';

class SliderAdderPage extends StatefulWidget {
  @override
  SliderAdderPageState createState() {
    return SliderAdderPageState();
  }
}

class SliderAdderPageState extends State<SliderAdderPage> {
  var _attributeController = new TextEditingController();
  var _minController = new TextEditingController();
  var _maxController = new TextEditingController();
  var _initialValueController = new TextEditingController();
  var _divisionController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PreviewSlider(
                                attribute: _attributeController.text,
                                min: double.parse(_minController.text),
                                max: double.parse(_maxController.text),
                                initial:
                                    double.parse(_initialValueController.text),
                                divisions: int.parse(_divisionController.text),
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
class PreviewSlider extends StatefulWidget {
  String attribute;
  double min;
  double max;
  double initial;
  int divisions;

  PreviewSlider(
      {Key key,
      this.attribute,
      this.min,
      this.max,
      this.initial,
      this.divisions})
      : super(key: key);

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
              ),
            ),
            RaisedButton(
              child: Text("Confirm"),
              onPressed: () {
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
                        ),
                      ),
                    ),
                  ),
                  key: Key(widget.attribute),
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
              },
            )
          ],
        ),
      ),
    );
  }
}
