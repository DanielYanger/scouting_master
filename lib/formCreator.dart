import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'componentSelector.dart';
import 'settings.dart';

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

class FormCreatorPageState extends State<FormCreatorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("624 Master Form Creator"),
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
            ? ReorderableListView(
                children: <Widget>[
                  for (Widget i in form)
                    Dismissible(
                      child: i,
                      direction: DismissDirection.startToEnd,
                      dismissThresholds: {
                        DismissDirection.startToEnd: 0.2,
                      },
                      key: ValueKey(i.key),
                      onDismissed: (left) {
                        setState(() {
                          details.removeAt(form.indexOf(i));
                          form.remove(i);
                          print(details);
                        });
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
                            padding: const EdgeInsets.all(15.0),
                            child: Icon(Icons.delete),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      confirmDismiss: (DismissDirection direction) async {
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
                    print(details);
                  });
                },
              )
            : ListView(
                children: <Widget>[
                  Card(
                    child: ListTile(
                      title: Center(child: Text("No Form Detected")),
                      subtitle: Center(
                          child: Text(
                              "Start creating a form by clicking the + button below.")),
                      isThreeLine: true,
                    ),
                  )
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
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

/*ListView.builder(
              itemCount: form != null && form.isNotEmpty ? form.length : 1,
              itemBuilder: form != null && form.isNotEmpty
                  ? (context, index) {
                return Column(
                  children: <Widget>[
                    Card(
                      child: form[index],
                    ),
                    SizedBox(height: 15),
                  ],
                );
              }
                  : (context, index) {
                return Card(
                  child: ListTile(
                    title: Center(child: Text("No Form Detected")),
                    subtitle: Center(
                        child: Text(
                            "Start creating a form by clicking the + button below.")),
                    isThreeLine: true,
                  ),
                );
              },
            ),*/
