
import 'package:final_project/ui/custom_drawer.dart';
import 'package:flutter/material.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({Key? key}) : super(key: key);

  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Information"),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Column(

      ),
    );
  }
}
