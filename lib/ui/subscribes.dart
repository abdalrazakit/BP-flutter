import 'package:final_project/ui/custom_drawer.dart';
import 'package:final_project/ui/map_screen.dart';
import 'package:flutter/material.dart';

class Subscribes extends StatefulWidget {
  const Subscribes({Key? key}) : super(key: key);

  @override
  _SubscribesState createState() => _SubscribesState();
}

class _SubscribesState extends State<Subscribes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subscribes"),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                child: MapSample(),
                color: Colors.deepPurple,
                height: 350,
              ),
              _buildTextField(),
              FloatingActionButton.extended(
                backgroundColor: Colors.white,
                onPressed: (){},
                label: Text('Save The Location'),
                icon: Icon(Icons.add),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.black,
                thickness: 2,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (ctx, index) => Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text("${index + 1}"),
                        ),
                        title: Text("My Home"),
                        onTap: () {},
                        trailing: IconButton(
                          icon: Icon(Icons.delete_outline),
                          onPressed: () {},
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                        indent: 20,
                        endIndent: 20,
                      ),
                    ],
                  ),
                  itemCount: 5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10.0)),
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      height: 170,
      width: 300,
      child: child,
    );
  }

  Widget _buildTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          label: Text(
            "Title",
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          prefixIcon: Icon(
            Icons.add_location_alt_outlined,
            color: Colors.white,
          ),
          hintStyle: TextStyle(
            color: Colors.purple,
            fontStyle: FontStyle.italic,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
