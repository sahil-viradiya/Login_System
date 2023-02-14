// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:login_system/repo.dart';
import 'package:login_system/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  Function callback;
  HomeScreen(this.callback);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
            onPressed: () {
              Repo.like().then((response) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Like Success")));
              }).catchError((error) {
                if (error.response != null) {
                  if (error.response.statusCode == 401) {
                    deletToken().then((value) {
                      return widget.callback();
                    });
                  }
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Like Failed")));
                }
                print(error);
              });
            },
            icon: Icon(Icons.thumb_up_sharp)),
      ),
    );
  }
}
