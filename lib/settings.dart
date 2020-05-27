import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'formCreator.dart';
import 'fileUtils.dart';
import 'formCreator.dart' as formCreator;

class StringGenerator {}

class SettingsPage extends StatefulWidget {
  List<Widget> form;
  List<List<String>> details;

  SettingsPage({Key key, this.form, this.details}) : super(key: key);

  @override
  SettingsPageState createState() {
    return SettingsPageState();
  }
}

class SettingsPageState extends State<SettingsPage> {
  static List<List<String>> createString(List<List<String>> detail) {
    List<List<String>> value = [];
    for (List<String> i in detail) {
      if (i.toString() == "FormBuilderRadio") {
        value.add(i);
        print(i.toString());
      } else if (i.toString() == "FormBuilderSlider") {
        value.add(i);
        print(i.toString());
      } else if (i.toString() == "FormBuilderTouchSpin") {
        value.add(i);
        print(i.toString());
      } else if (i.toString() == "FormBuilderCheckboxList") {
        value.add(i);
        print(i.toString());
      } else if (i.toString() == "Center(alignment: center)") {
        value.add(i);
        print(i.toString());
      } else if (i.toString() == "FormBuilderDropdown") {
        value.add(i);
        print(i.toString());
      } else if (i.toString() == "FormBuilderTextField") {
        value.add(i);
        print(i.toString());
      }
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: Column(
          children: <Widget>[
            Card(
              child: ListTile(
                title: Text("Remove Component"),
                subtitle: Text("Remove the last component."),
                isThreeLine: true,
                leading: Icon(
                  Icons.remove_circle,
                  size: 50,
                ),
                onTap: () {
                  widget.form.removeLast();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => FormCreatorPage()),
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Export Form"),
                subtitle: Text("Export the current form."),
                isThreeLine: true,
                leading: Icon(
                  Icons.cloud_upload,
                  size: 50,
                ),
                onTap: () {
                  FileUtils.saveToFile(widget.details, "newform");
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => FormCreatorPage()),
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ),
          ],
        ));
  }
}
