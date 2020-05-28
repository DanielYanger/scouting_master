import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'formCreator.dart';
import 'fileUtils.dart';

class StringGenerator {}

// ignore: must_be_immutable
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
  static String createString(List<List<String>> detail) {
    String value = "";
    for (List<String> i in detail) {
      value += i.toString() + ";";
    }
    print(value);
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
                  widget.details.removeLast();
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
                title: Text("Clear Form"),
                subtitle: Text("Remove all current components."),
                isThreeLine: true,
                leading: Icon(
                  Icons.close,
                  size: 50,
                ),
                onTap: () {
                  widget.form.clear();
                  widget.details.clear();
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
                  FileUtils.saveToFile(createString(widget.details), "newform");
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
