import 'package:final_project/ui/new_report/new_report_screen.dart';
import 'package:final_project/ui/personal_information.dart';
import 'package:final_project/ui/subscribes/subscribes_screen.dart';
import 'package:flutter/material.dart';

import 'map_screen.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.black38
                // image: DecorationImage(
                //   image: AssetImage("assets/images/drawer.jpg"),
                //   fit: BoxFit.cover,
                // ),
                ),
            child: Text(
              'Drawer',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.report_gmailerrorred,
              color: Colors.red,
              size: 28,
            ),
            title: Text('New Report'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return NewReportScreen();
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.add_alert_outlined,
              color: Colors.red,
              size: 28,
            ),
            title: Text('Subscribes'),
            onTap: () {
              //Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SubscribesScreen();
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.local_fire_department,
              size: 28,
            ),
            title: Text('Active Fires'),
            onTap: () {
              //Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return MapSample();
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle,
              size: 28,
            ),
            title: Text('Profile'),
            onTap: () {
              //Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return PersonalInformation();
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 28,
            ),
            title: Text('Settings'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('About'),
          ),
        ],
      ),
    );
  }
}
