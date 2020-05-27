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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: ListView.builder(
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
          ),
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
