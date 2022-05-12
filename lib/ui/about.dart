import 'package:flutter/material.dart';

import 'custom_drawer.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text("About Application"),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
              clipBehavior: Clip.hardEdge,
              elevation: 30,
              margin: EdgeInsets.all(20.0),
              child: Container(child: Image.asset('assets/images/about1.jpg'))),
          Text(
            'Summary',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'This project was created by Yeşil kalacak team,'
              'In this project, we use mainly artificial intelligence techniques for the detection of forest fires. '
              'We provide an interactive map that shows the situation of the fires in a specific area, '
              'with the weather conditions that could affect the fires. We  provide a mobile application intended to use for reporting fires by humans. '
              'Also, the application can notify the people around the confirmed fire to get attention.',
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Our Team',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            height: 12,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map_outlined),
                  Text(
                    '   Abdulrazaq Alhajsaeed',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone_android),
                  Text(
                    '   Muhammed ELHASAN',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_tree_outlined),
                  Text(
                    '   Yara Isa',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
    ;
  }
}