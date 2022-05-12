import 'package:final_project/ui/custom_drawer.dart';
import 'package:final_project/ui/all_fires/all_fires_screen.dart';
import 'package:final_project/ui/subscribes/subscribes_cubit.dart';
import 'package:final_project/ui/subscribes/subscribes_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../pick_map_screen.dart';
import 'all_fires_cubit.dart';
import 'all_fires_state.dart';

class AllFiresScreen extends StatefulWidget {
  const AllFiresScreen({Key? key}) : super(key: key);

  @override
  _AllFiresScreenState createState() => _AllFiresScreenState();
}

class _AllFiresScreenState extends State<AllFiresScreen> {
  final titleController = TextEditingController();
  late AllFiresCubit bloc;

  @override
  void initState() {
    bloc = AllFiresCubit();
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
          appBar: AppBar(
            title: const Text("AllFires"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(),
          body: PickMapSample(bloc: bloc),
        );
      },
      listener: (BuildContext context, AllFiresState? state) {
        if (state?.success ?? false) {}
      },
    );
  }
}
