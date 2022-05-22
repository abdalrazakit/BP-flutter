import 'package:final_project/ui/custom_drawer.dart';
import 'package:final_project/ui/all_fires/all_fires_screen.dart';
import 'package:final_project/ui/new_report/new_report_screen.dart';
import 'package:final_project/ui/subscribes/subscribes_cubit.dart';
import 'package:final_project/ui/subscribes/subscribes_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../pick_map_screen.dart';
import 'all_fires_cubit.dart';
import 'all_fires_state.dart';

class AllFiresScreen extends StatefulWidget {
  final int? moveToFireById;

  const AllFiresScreen({Key? key, this.moveToFireById}) : super(key: key);

  @override
  _AllFiresScreenState createState() => _AllFiresScreenState();
}

class _AllFiresScreenState extends State<AllFiresScreen> {
  final titleController = TextEditingController();
  late AllFiresCubit bloc;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    bloc = AllFiresCubit(moveToFireById: widget.moveToFireById);
    bloc.getSubscribes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllFiresCubit, AllFiresState>(
      bloc: bloc,
      builder: (context, AllFiresState state) {
        if (state.loading) {
          return const Material(
              child: Center(
            child: CircularProgressIndicator(),
          ));
        }

        return Scaffold(
          key: _scaffoldKey,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return NewReportScreen();
                  },
                ),
              );
            },
            child: Icon(Icons.local_fire_department),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          appBar: AppBar(
            title: const Text("All Fires Map"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(
            onTap: () {
              if (_scaffoldKey.currentState!.isDrawerOpen) {
                _scaffoldKey.currentState!.openEndDrawer();
              }
            },
          ),
          body: PickMapSample(bloc: bloc),
        );
      },
      listener: (BuildContext context, AllFiresState? state) {
        if (state?.success ?? false) {}
      },
    );
  }
}
