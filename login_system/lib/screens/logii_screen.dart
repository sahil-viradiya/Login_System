// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, body_might_complete_normally_nullable, avoid_print, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:login_system/repo.dart';
import 'package:login_system/utils/utils.dart';

enum STATUS { init, submitting, loginComplte, loginFailed }

class LoginScreen extends StatefulWidget {
  Function logincallback;
  LoginScreen(this.logincallback);
  String? emailError;
  String? passwordErro;
  String email = "";
  String password = "";
  var formKey = GlobalKey<FormState>();
  var ststus = STATUS.init;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Screen"),
      ),
      body: widget.ststus == STATUS.init
          ? Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(24),
              child: Form(
                key: widget.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required";
                        }
                        widget.email = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter Your Email",
                        errorText: widget.emailError,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required";
                        }
                        widget.password = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter Your Password",
                        errorText: widget.passwordErro,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (widget.formKey.currentState!.validate()) {
                          login();
                          setState(() {
                            widget.ststus = STATUS.submitting;
                          });
                        }
                      },
                      child: Text("data"),
                    ),
                  ],
                ),
              ),
            )
          : widget.ststus == STATUS.submitting
              ? CircularProgressIndicator()
              : widget.ststus == STATUS.loginFailed
                  ? Center(
                      child: Text("Fails"),
                    )
                  : null,
    );
  }

  void login() {
    Repo.postData(widget.email, widget.password).then((response) {
      widget.ststus = STATUS.loginComplte;
      storeToken(response.data['token']).then((value) {
        print(response.data['token']);
        widget.logincallback(response.data['token']);
      }).catchError((e) {
        print(e);
      });
    }).catchError((error) {
      print(error);
      if (error.response != null) {
        print(error.response!.data);
        print(error.response!.statusCode);
        setState(() {
          widget.ststus = STATUS.init;
          // widget.ststus = STATUS.loginFailed;
          widget.emailError =
              error.response.statusCode == 404 ? "user note found" : null;
          widget.passwordErro =
              error.response.statusCode == 400 ? "password  Incorrect" : null;
        });
      }
    });
  }
}
