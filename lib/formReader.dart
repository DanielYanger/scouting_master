import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:scoutingmaster/fileUtils.dart';

import 'formCreator.dart' as FormBuilder;
import 'formCreator.dart';

class FormReader extends StatefulWidget {
  final String stringForm;

  FormReader({Key key, this.stringForm}) : super(key: key);

  @override
  FormReaderState createState() {
    return FormReaderState();
  }
}

List<Widget> finalForm = [];

List<Widget> getForm() {
  return finalForm;
}

List<FormBuilderFieldOption> createSetCheckbox(List<String> list) {
  List<FormBuilderFieldOption> result = [];
  for (String i in list) {
    result.add(FormBuilderFieldOption(
      value: i,
    ));
  }
  return result;
}

List<DropdownMenuItem<dynamic>> createSetDropdown(List<dynamic> list) {
  List<DropdownMenuItem> result = new List<DropdownMenuItem>();
  result = list
      .map((option) => DropdownMenuItem(
            child: Text('$option'),
            value: option,
          ))
      .toList();
  return result;
}

void formCreator(String stringForm, BuildContext context) {
  FormBuilder.clearForm();
  FormBuilder.clearDetails();
  List<String> separatedForm = stringForm.split(";");
  separatedForm.removeLast();
  for (String i in separatedForm) {
    i = i.substring(1, i.length - 1);
    List<String> tempWidget = i.split(",");
    //break
    FormBuilder.addDetails(tempWidget);

    if (tempWidget[0] == "FormBuilderRadio") {
      List<String> options = [];
      for (int i = 2; i < tempWidget.length; i++) {
        options.add(tempWidget[i]);
      }
      FormBuilder.addComponent(
        new Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            child: Container(
              height: 40 + 48.0 * options.length,
              child: FormBuilderRadio(
                attribute: tempWidget[1],
                options: options
                    .map((lang) => FormBuilderFieldOption(
                          value: lang,
                          child: Text('$lang'),
                        ))
                    .toList(growable: false),
                decoration: InputDecoration(labelText: tempWidget[1]),
                leadingInput: true,
                validators: [FormBuilderValidators.required()],
                activeColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          key: Key(tempWidget[1]),
        ),
      );
    }
    //break

    else if (tempWidget[0] == "FormBuilderCheckboxList") {
      List<String> options = [];
      for (int i = 2; i < tempWidget.length; i++) {
        options.add(tempWidget[i]);
      }
      FormBuilder.addComponent(
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            child: Container(
              height: 40 + 48.0 * options.length,
              child: FormBuilderCheckboxList(
                activeColor: Theme.of(context).primaryColor,
                attribute: tempWidget[1],
                options: createSetCheckbox(options),
                decoration: InputDecoration(labelText: tempWidget[1]),
              ),
            ),
          ),
          key: Key(tempWidget[1]),
        ),
      );
    }
    //break

    else if (tempWidget[0] == "FormBuilderBoolean") {
      FormBuilder.addComponent(Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          child: Container(
            height: 136,
            child: FormBuilderRadio(
              attribute: tempWidget[1],
              options: ["Yes", "No"]
                  .map((lang) => FormBuilderFieldOption(
                        value: lang,
                        child: Text('$lang'),
                      ))
                  .toList(growable: false),
              validators: [FormBuilderValidators.required()],
              decoration: InputDecoration(labelText: tempWidget[1]),
              activeColor: Theme.of(context).primaryColor,
            ),
          ),
        ),
        key: Key(tempWidget[1]),
      ));
    }
    //break

    else if (tempWidget[0] == "FormBuilderTouchSpin") {
      FormBuilder.addComponent(Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          child: Container(
            height: 96,
            child: FormBuilderTouchSpin(
              attribute: tempWidget[1],
              decoration: InputDecoration(labelText: tempWidget[1]),
              initialValue: 0,
              step: 1,
              iconSize: 48.0,
              min: 0,
              addIcon: Icon(Icons.add_circle),
              subtractIcon: Icon(Icons.remove_circle),
            ),
          ),
        ),
        key: Key(tempWidget[1]),
      ));
    }
    //break

    else if (tempWidget[0] == "FormBuilderDropdown") {
      List<String> options = [];
      for (int i = 3; i < tempWidget.length; i++) {
        options.add(tempWidget[i]);
      }
      FormBuilder.addComponent(
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            height: 70,
            child: Card(
              child: FormBuilderDropdown(
                attribute: tempWidget[1],
                decoration: InputDecoration(
                  labelText: tempWidget[1],
                ),
                hint: Text(tempWidget[2]),
                validators: [FormBuilderValidators.required()],
                items: createSetDropdown(options),
              ),
            ),
          ),
          key: Key(tempWidget[1]),
        ),
      );
    }
    //break

    else if (tempWidget[0] == "FormBuilderSlider") {
      FormBuilder.addComponent(Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          child: Container(
            height: 114,
            child: FormBuilderSlider(
              attribute: tempWidget[1],
              min: double.parse(tempWidget[2]),
              max: double.parse(tempWidget[3]),
              initialValue: double.parse(tempWidget[4]),
              divisions: int.parse(tempWidget[5]),
              decoration: InputDecoration(
                labelText: tempWidget[1],
              ),
            ),
          ),
        ),
        key: Key(tempWidget[1]),
      ));
    }
    //break

    else if (tempWidget[0] == "FormBuilderTextField") {
      FormBuilder.addComponent(
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            child: Container(
              child: FormBuilderTextField(
                attribute: "${tempWidget[1]}",
                decoration: InputDecoration(
                  labelText: "${tempWidget[1]}",
                ),
                readOnly: true,
              ),
            ),
          ),
          key: Key(tempWidget[1]),
        ),
      );
    }
    //break

    else if (tempWidget[0] == "Divider") {
      FormBuilder.addComponent(
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            height: 30 + double.parse(tempWidget[2]),
            child: Card(
              child: Center(
                child: Text(
                  tempWidget[1],
                  style: TextStyle(fontSize: double.parse(tempWidget[2])),
                ),
              ),
            ),
            key: Key(tempWidget[1]),
          ),
        ),
      );
    }
  }
}

class FormReaderState extends State<FormReader> {
  Future<File> file;
  String stringForm = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Import Form"),
      ),
      body: new Center(
          child: new Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: new SingleChildScrollView(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                child: Column(
                  children: <Widget>[
                    new RaisedButton(
                      onPressed: () {
                        file = FileUtils.pickFile;
                        FileUtils.readFile(file).then((data) {
                          stringForm = data;
                          print("File Picked");
                          formCreator(stringForm, context);
                        });
                      },
                      child: new Text("Choose Form"),
                    ),
                    new RaisedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FormCreatorPage()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: new Text("Import"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
