import 'package:flutter/material.dart';
import 'map_screen.dart';
import 'custom_drawer.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("A New Report"),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: sendReport,
                child: Text(
                  "Send!",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ))
          ],
        ),
        drawer: CustomDrawer(),
        body: ListView(
          children: [
            Column(
              children: [
                Container(
                  child: MapSample(),
                  color: Colors.deepPurple,
                  height: 350,
                ),
                SizedBox(
                  height: 10,
                ),
                _buildDescription(),
                SizedBox(
                  height: 20,
                ),
                _addImage(),
                SizedBox(
                  height: 50,
                ),
                //_buildSendButton(),
              ],
            ),
          ],
        ));
  }

  Widget _addLocation() {
    return Center(
      child: Material(
        child: FloatingActionButton.extended(
          backgroundColor: Colors.white,
          onPressed: () {},
          label: Text('Select a Location'),
          icon: Icon(Icons.map),
        ),
      ),
    );
  }

  Widget _addImage() {
    return Center(
      child: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        onPressed: () {},
        label: Text('Take a Photo'),
        icon: Icon(Icons.camera_alt_outlined),
      ),
    );
  }

  Widget _buildDescription() {
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                label: Text(
                  "Description",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                prefixIcon: Icon(
                  Icons.description_outlined,
                  color: Colors.white,
                ),
                hintStyle: TextStyle(
                  color: Colors.purple,
                  fontStyle: FontStyle.italic,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
              ),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

// _buildSendButton() {
//   return FloatingActionButton.extended(
//     backgroundColor: Colors.red,
//     onPressed: () {},
//     label: Text('Send!'),
//     icon: Icon(Icons.add),
//   );
// }

  void sendReport() {

  }
}
