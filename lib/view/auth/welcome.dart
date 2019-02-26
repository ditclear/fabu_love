import 'dart:convert';

import 'package:fabu_love/di/module.dart';
import 'package:fabu_love/helper/constants.dart';
import 'package:fabu_love/main.dart';
import 'package:fabu_love/model/model.dart';
import 'package:fabu_love/view/home/home.dart';
import 'package:flutter/material.dart';

class WelcomeWidget extends StatelessWidget {
  _dispach(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      final user = spUtil.getString(KEY_USER);
      if (user != null) {
        Navigator. pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) {
                return BackdropDemo();
              },
              fullscreenDialog: true),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) {
                return MyStatefulWidget();
              },
              fullscreenDialog: true),
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    _dispach(context);
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text("Welcome to fabu.love"),
      ),
    );
  }
}
