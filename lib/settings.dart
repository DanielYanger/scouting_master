import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoutingmaster/exportForm.dart';
import 'package:scoutingmaster/scouting_icons_icons.dart';

import 'exportForm.dart';
import 'formCreator.dart';
import 'formReader.dart';

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
                title: Text("Clear Form"),
                subtitle: Text("Remove all current components."),
                leading: Icon(
                  Icons.close,
                  size: 50,
                ),
                onTap: () async {
                  return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Confirm"),
                          content: const Text(
                              "Are you sure you wish to clear the form?"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("CONFIRM"),
                              onPressed: () {
                                widget.form.clear();
                                widget.details.clear();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FormCreatorPage()),
                                  (Route<dynamic> route) => false,
                                );
                              },
                            ),
                            FlatButton(
                              child: Text("CANCEL"),
                              onPressed: () => Navigator.of(context).pop(),
                            )
                          ],
                        );
                      });
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Export Form"),
                subtitle: Text("Export the current form."),
                leading: Icon(
                  Icons.cloud_upload,
                  size: 50,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ExportPage(
                                details: widget.details,
                              )));
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.restore_page,
                  size: 50,
                ),
                title: Text("Import Form"),
                subtitle: Text("Import an existing form to edit."),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FormReader()),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("About the App"),
                subtitle: Text(""),
                leading: Icon(
                  Icons.info,
                  size: 50,
                ),
                onTap: () {
                  showAboutDialog(
                      applicationIcon: Icon(ScoutingIcons.radioactive),
                      context: context,
                      applicationVersion: '1.5.1',
                      applicationLegalese:
                      "This app was developed by Daniel Yang, a programmer for FRC Team 624. This is one of the two apps developed for the Team 624 Scouting Team for use in many years to come. The purpose of this app is to enable the head scout to create master forms compatable with the Scouter App without the need to learn any code.");
                },
              ),
            ),
          ],
        ));
  }
}
