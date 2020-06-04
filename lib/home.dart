import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'formCreator.dart';

//unused right now
class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("624 Master App"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Card(
              child: ListTile(
                title: Text("Create New Match Form"),
                subtitle: Text(
                    "Create a new match form to export for use in the 624 Scouting App."),
                isThreeLine: true,
                leading: Icon(
                  Icons.add,
                  size: 50,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FormCreatorPage()),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Create New Pit Form"),
                subtitle: Text(
                    "Create a new pit form to export for use in the 624 Scouting App."),
                isThreeLine: true,
                leading: Icon(
                  Icons.add,
                  size: 50,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FormCreatorPage()),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
