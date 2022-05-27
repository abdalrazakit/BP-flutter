import 'package:final_project/ui/custom_drawer.dart';
import 'package:final_project/ui/all_fires/all_fires_screen.dart';
import 'package:final_project/ui/subscribes/subscribes_cubit.dart';
import 'package:final_project/ui/subscribes/subscribes_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../pick_map_screen.dart';

class SubscribesScreen extends StatefulWidget {
  const SubscribesScreen({Key? key}) : super(key: key);

  @override
  _SubscribesScreenState createState() => _SubscribesScreenState();
}

class _SubscribesScreenState extends State<SubscribesScreen> {
  final titleController = TextEditingController();
  late SubscribesCubit bloc;

  @override
  void initState() {
    bloc = SubscribesCubit();
    bloc.getSubscribes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubscribesCubit, SubscribesState>(
      bloc: bloc,
      builder: (context, SubscribesState state) {
        if (state.loading) {
          return const Material(
              child: Center(
            child: CircularProgressIndicator(),
          ));
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("Subscribes"),
            centerTitle: true,
          ),
       //   drawer: CustomDrawer(),
          body: Stack(
            children: [
              Column(
                children: [

                  Container(
                    child: Builder(builder: (context) {
                      return PickMapSample(bloc: bloc);
                    }),
                    color: Colors.deepPurple,
                    height: 250,
                  ),

                  _buildTextField(),
                  FloatingActionButton.extended(
                    backgroundColor: Colors.white,
                    onPressed: () {
                      if (validate()) {
                        bloc.saveSubscribe();
                      } else {
                        Fluttertoast.showToast(
                          msg: "Please fill in all fields",
                        );
                      }
                    },
                    label: Text('Save The Location'),
                    icon: Icon(Icons.add),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 2,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (ctx, index) {
                        final item = bloc.subscribes[index];
                        return Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                child: Text("${index + 1}"),
                              ),
                              title: Text(item['description']),
                              onTap: () {},
                               trailing: IconButton(
                                 icon: Icon(Icons.delete_outline),
                                 onPressed: () {
                                   bloc.deleteSubscribe (item['id']);
                                 },
                               ),
                            ),
                            const Divider(
                              color: Colors.black,
                              indent: 20,
                              endIndent: 20,
                            ),
                          ],
                        );
                      },
                      itemCount: bloc.subscribes.length,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      listener: (BuildContext context, SubscribesState? state) {
        if (state?.success ?? false  ) {

          bloc.clear();
          Fluttertoast.showToast(
            msg: "Done successfully!",
          );
          bloc.getSubscribes();
        }
      },
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
        onChanged:  (s){
          bloc.description=s;
        },
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

  bool validate() {
    return (bloc.description ?? '').length  > 3 && bloc.latLng != null;
  }
}
