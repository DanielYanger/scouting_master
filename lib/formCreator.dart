import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:scoutingmaster/custom_scouting_icon_icons.dart';

import 'booleanAdder.dart';
import 'checkboxAdder.dart';
import 'componentSelector.dart';
import 'counterAdder.dart';
import 'dividerAdder.dart';
import 'dropdownAdder.dart';
import 'radioAdder.dart';
import 'settings.dart';
import 'sliderAdder.dart';
import 'textboxAdder.dart';

class FormCreatorPage extends StatefulWidget {
  @override
  FormCreatorPageState createState() {
    return FormCreatorPageState();
  }
}

List<Widget> form = [];
List<List<String>> details = [];

void addComponent(Widget item) {
  form.add(item);
}

void addDetails(List<String> item) {
  details.add(item);
}

void editComponent(Widget item, int index) {
  form[index] = item;
}

void editDetails(List<String> item, int index) {
  details[index] = item;
}

void clearForm() {
  form.clear();
}

void clearDetails() {
  details.clear();
}

// ignore: missing_return
Widget editForm(List<String> details, int index) {
  if (details[0] == "FormBuilderBoolean") {
    return BooleanAdderPage(
      attribute: details[1],
      index: index,
    );
  } else if (details[0] == "FormBuilderTouchSpin") {
    return CounterAdderPage(
      attribute: details[1],
      index: index,
    );
  } else if (details[0] == "Divider") {
    return DividerAdderPage(
      attribute: details[1],
      fontSize: double.parse(details[2]),
      index: index,
    );
  } else if (details[0] == "FormBuilderTextField") {
    return TextboxAdderPage(
      attribute: details[1],
      index: index,
    );
  } else if (details[0] == "FormBuilderCheckboxList") {
    return CheckboxAdderPage(
      attribute: details[1],
      options: details.sublist(2),
      index: index,
    );
  } else if (details[0] == "FormBuilderDropdown") {
    return DropdownAdderPage(
      attribute: details[1],
      hint: details[2],
      options: details.sublist(3),
      index: index,
    );
  } else if (details[0] == "FormBuilderRadio") {
    return RadioAdderPage(
      attribute: details[1],
      options: details.sublist(2),
      index: index,
    );
  } else if (details[0] == "FormBuilderSlider") {
    return SliderAdderPage(
      attribute: details[1],
      min: double.parse(details[2]),
      max: double.parse(details[3]),
      initialValue: double.parse(details[4]),
      divisions: int.parse(details[5]),
      index: index,
    );
  }
}

class FormCreatorPageState extends State<FormCreatorPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("624 Form Creator"),
        leading: Icon(
          CustomScoutingIcon.radioactive,
          size: 50,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SettingsPage(
                          form: form,
                          details: details,
                        )),
              );
            },
          ),
        ],
      ),
      body: Container(
        height: 1920,
        child: form.isNotEmpty
            ? FormBuilder(
                key: _fbKey,
                readOnly: false,
                child: ReorderableListView(
                  children: <Widget>[
                    for (Widget i in form)
                      Dismissible(
                        child: i,
                        direction: DismissDirection.horizontal,
                        dismissThresholds: {
                          DismissDirection.startToEnd: 0.3,
                          DismissDirection.endToStart: 0.3,
                        },
                        key: ValueKey(i.key),
                        onDismissed: (direction) {
                          if (direction == DismissDirection.startToEnd) {
                            setState(() {
                              details.removeAt(form.indexOf(i));
                              form.remove(i);
                            });
                          } else if (direction ==
                              DismissDirection.endToStart) {}
                        },
                        background: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: new BoxDecoration(
                                color: Colors.red,
                                borderRadius: new BorderRadius.only(
                                  bottomRight: const Radius.circular(10.0),
                                  topRight: const Radius.circular(10.0),
                                  bottomLeft: const Radius.circular(10.0),
                                  topLeft: const Radius.circular(10.0),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Icon(Icons.delete),
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                        secondaryBackground: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: new BoxDecoration(
                                color: Colors.amber,
                                borderRadius: new BorderRadius.only(
                                  bottomRight: const Radius.circular(10.0),
                                  topRight: const Radius.circular(10.0),
                                  bottomLeft: const Radius.circular(10.0),
                                  topLeft: const Radius.circular(10.0),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Icon(Icons.edit),
                            ),
                            alignment: Alignment.centerRight,
                          ),
                        ),
                        // ignore: missing_return
                        confirmDismiss: (DismissDirection direction) async {
                          if (direction == DismissDirection.startToEnd) {
                            return await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Confirm"),
                                  content: const Text(
                                      "Are you sure you wish to delete this item?"),
                                  actions: <Widget>[
                                    FlatButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: const Text("DELETE")),
                                    FlatButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text("CANCEL"),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            print(form);
                            List<String> temp = details[form.indexOf(i)];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => editForm(
                                  temp,
                                  form.indexOf(i),
                                ),
                              ),
                            );
                          }
                        },
                      )
                  ],
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) {
                        newIndex -= 1;
                      }
                      final item = form.removeAt(oldIndex);
                      form.insert(newIndex, item);
                      final detail = details.removeAt(oldIndex);
                      details.insert(newIndex, detail);
                    });
                  },
                ),
              )
            : ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      child: ListTile(
                        title: Center(child: Text("No Form Detected")),
                        subtitle: Text(
                          "Start creating a form by clicking the + button below.",
                          textAlign: TextAlign.center,
                        ),
                        isThreeLine: true,
                        leading: Icon(
                          Icons.warning,
                          size: 50,
                          color: Colors.red,
                        ),
                        trailing: Icon(
                          Icons.warning,
                          size: 50,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  )
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ComponentSelectorPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
