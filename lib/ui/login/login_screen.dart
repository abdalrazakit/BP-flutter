import 'package:final_project/ui/login/login_cubit.dart';
import 'package:final_project/ui/new_report/new_report_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginCubit cubit = LoginCubit();
  TextEditingController _phonenumbercontroller = new TextEditingController(text: '+905453130300' );
  TextEditingController _smsTextController = new TextEditingController(text:'112233' );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: false,
      ),
      body: BlocListener(
        bloc: cubit,
        listener: (context, login) {
          if ((login as LoginState).login_success != true) {
            _showToast(context);
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return NewReportScreen();
                },
              ),
            );
          }
        },
        child: BlocBuilder(
            bloc: cubit,
            builder: (context, LoginState state) {
              if (state.loading) {
                return Center(child: const CircularProgressIndicator());
              }
              return Form(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _phonenumbercontroller,
                              decoration: InputDecoration(
                                  labelText: "Phone Number",
                                  icon: Icon(Icons.phone),
                                  errorText: state.login_error),
                            ),
                          ),
                          SizedBox(width: 16),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: TextButton(
                                onPressed: () {
                                  cubit.sendCode(_phonenumbercontroller.text);
                                },
                                child: Text(
                                  "Send Code",
                                  style: TextStyle(fontSize: 14),
                                )),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _smsTextController,
                          decoration: const InputDecoration(
                            labelText: "SMS Code",
                            icon: Icon(Icons.message_rounded),
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            cubit.login(
                                _phonenumbercontroller.text,
                                _smsTextController.text,
                            (  await  FirebaseMessaging.instance.getToken()) !);
                          },
                          child: Text("Login"),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Code Sended'),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
