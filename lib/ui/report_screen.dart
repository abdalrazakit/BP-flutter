import 'dart:io';

import 'package:final_project/new_report_cubit.dart';
import 'package:final_project/ui/pick_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'map_screen.dart';
import 'custom_drawer.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final controller = TextEditingController();
  late NewReportCubit bloc;

  @override
  void initState() {
    bloc = NewReportCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewReportCubit, NewReportState>(
      bloc: bloc,
      builder: (context, NewReportState state) {
        if (state.loading) {
          return Material(color: Colors.white,
              child: Center(
            child: CircularProgressIndicator(),
          ));
        }
        return Scaffold(
            appBar: AppBar(
              title: Text("A New Report"),
              centerTitle: true,
              actions: [
                TextButton(
                    onPressed: () {
                      bloc.saveReport();
                    },
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
                      child: Builder(builder: (context) {
                        return PickMapSample(bloc: bloc);
                      }),
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
      },
      listener: (BuildContext context, NewReportState? state) {
        if (state?.success ?? false) {
          Navigator.pop(context);
        }
      },
    );
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

        onPressed: () async {
          final image =
              await ImagePicker().getImage(source: ImageSource.camera);

          //bloc.changeImage(image?.path);
        },
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
              controller: controller,
              onChanged: (s) {
                bloc.changeDesc(controller.text);
              },
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

}
