import 'package:final_project/core/user_pref.dart';
import 'package:final_project/ui/about.dart';
import 'package:final_project/ui/all_fires/all_fires_screen.dart';
import 'package:final_project/ui/login/login_screen.dart';
import 'package:final_project/ui/new_report/new_report_screen.dart';
import 'package:final_project/ui/subscribes/subscribes_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

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
            padding: EdgeInsets.only(top: 20,left: 10),
            decoration: BoxDecoration(
              color: Colors.black38,
              image: DecorationImage(
                image: AssetImage("assets/images/dbg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Text(
              'Yeşil Kalacak',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.report_gmailerrorred,
              color: Colors.red,
              size: 35,
            ),
            title: Text(
              'New Report',
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
            ),
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
              size: 35,
            ),
            title: Text(
              'Subscribes',
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
            ),
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
              color: Colors.red,
              size: 35,
            ),
            title: Text(
              'Active Fires',
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
            ),
            onTap: () {
              //Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AllFiresScreen();
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: Colors.red,
              size: 35,
            ),
            title: Text(
              'About',
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
            ),
            onTap: () {
              //Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return About();
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.red,
              size: 35,
            ),
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
            ),
            onTap: () async {
              await deleteToken();
              await FirebaseMessaging.instance.deleteToken();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (context) {
                  return LoginScreen();
                },
              ), (c) => false);
            },
          ),
        ],
      ),
    );
  }
}
