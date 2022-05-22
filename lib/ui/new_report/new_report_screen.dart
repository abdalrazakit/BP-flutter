import 'dart:io';

import 'package:final_project/ui/new_report/new_report_cubit.dart';
import 'package:final_project/ui/pick_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../custom_drawer.dart';
import 'new_report_state.dart';

class NewReportScreen extends StatefulWidget {
  const NewReportScreen({Key? key}) : super(key: key);

  @override
  _NewReportScreenState createState() => _NewReportScreenState();
}

class _NewReportScreenState extends State<NewReportScreen> {
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
          return const Material(
              child: Center(
            child: CircularProgressIndicator(),
          ));
        }
        return Scaffold(
            appBar: AppBar(
              title: const Text("New Report",style: TextStyle(fontStyle: FontStyle.normal ),),
              centerTitle: true,
              actions: [
                TextButton(
                    onPressed: () {
                      if (validate()) {
                        bloc.saveReport();
                      } else {
                        Fluttertoast.showToast(
                          msg: "please fill all inputs",
                        );
                      }
                    },
                    child: const Text(
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
                      height: 300,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildDescription(),
                    const SizedBox(
                      height: 20,
                    ),

                    if (bloc.image == null) _addImage() else
                      _previewImage(),

                    const SizedBox(
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
          //    Navigator.pop(context);

          Fluttertoast.showToast(
            msg: "Report Sended!",
          );
          controller.clear();
          bloc.clear();
        }
      },
    );
  }

  Widget _addImage() {
    return Center(
      child: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        onPressed: () async {
          final selectedImage = (await ImagePicker().getImage(
                  source: ImageSource.camera,
                  imageQuality: 50,
                  maxHeight: 720,
                  maxWidth: 1024))
              ?.path;

          bloc.changeImage(selectedImage);
        },
        label: const Text('Take a Photo'),
        icon: const Icon(Icons.camera_alt_outlined),
      ),
    );
  }

  Widget _previewImage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
          borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: () {
              bloc.changeImage(null);
            },
            child: Stack(
              children: [
                Image.file(
                  File(bloc.image!),
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                ),
                Positioned.fill(
                    child: Container(
                  color: Colors.black38,
                )),
                const Positioned.fill(
                  child: Center(
                    child: Icon(Icons.clear),
                  ),
                )
              ],
            ),
          )),
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
                label: const Text(
                  "Description",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                prefixIcon: const Icon(
                  Icons.description_outlined,
                  color: Colors.white,
                ),
                hintStyle: const TextStyle(
                  color: Colors.purple,
                  fontStyle: FontStyle.italic,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: const BorderSide(
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

  bool validate() {
    return //(bloc.desc ?? '').length  > 3 &&
        bloc.image != null && bloc.latLng != null;
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
