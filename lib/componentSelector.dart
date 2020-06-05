import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoutingmaster/dividerAdder.dart';
import 'package:scoutingmaster/radioAdder.dart';
import 'package:scoutingmaster/scouting_icons_icons.dart';

import 'booleanAdder.dart';
import 'checkboxAdder.dart';
import 'counterAdder.dart';
import 'dividerAdder.dart';
import 'dropdownAdder.dart';
import 'sliderAdder.dart';
import 'textboxAdder.dart';

class ComponentSelectorPage extends StatefulWidget {
  @override
  ComponentSelectorPageState createState() {
    return ComponentSelectorPageState();
  }
}

class ComponentSelectorPageState extends State<ComponentSelectorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Component"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Card(
              child: ListTile(
                title: Text("Divider"),
                subtitle: Text("Insert a labeled divier"),
                leading: Icon(
                  ScoutingIcons.divider,
                  size: 50,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DividerAdderPage()),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Boolean"),
                subtitle: Text("Insert a boolean"),
                leading: Icon(
                  Icons.edit_attributes,
                  size: 50,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BooleanAdderPage()),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Radio"),
                subtitle: Text("Insert a radio"),
                leading: Icon(
                  ScoutingIcons.radio_button,
                  size: 50,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RadioAdderPage()),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Counter"),
                subtitle: Text("Insert a counter"),
                leading: Icon(
                  ScoutingIcons.counter,
                  size: 50,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CounterAdderPage()),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Slider"),
                subtitle: Text("Insert a slider"),
                leading: Icon(
                  ScoutingIcons.sliders,
                  size: 50,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SliderAdderPage()),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Checkbox"),
                subtitle: Text("Insert a checkbox"),
                leading: Icon(
                  Icons.check_box_outline_blank,
                  size: 50,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckboxAdderPage()),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Dropdown"),
                subtitle: Text("Insert a dropdown"),
                leading: Icon(
                  ScoutingIcons.down_arrow,
                  size: 50,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DropdownAdderPage()),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Textbox"),
                subtitle: Text("Insert a textbox"),
                leading: Icon(
                  Icons.text_fields,
                  size: 50,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TextboxAdderPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
