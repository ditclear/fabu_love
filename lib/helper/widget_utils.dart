import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fabu_love/di/module.dart';
import 'package:fabu_love/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:fabu_love/helper/exceptions.dart';

dispatchFailure(BuildContext context, dynamic e) {
  var message = e.toString();
  if (e is DioError) {
    final response = e.response;

    if (response?.statusCode == 401) {
      spUtil.putString(KEY_TOKEN, null);
      message = "登录过期，请重新登录";
      Navigator.pushReplacementNamed(context, 'login');
    } else if (403 == response?.statusCode) {
      message = "禁止访问";
    } else if (404 == response?.statusCode) {
      message = "链接错误";
    } else if (500 == response?.statusCode) {
      message = "服务器内部错误";
    } else if (503 == response?.statusCode) {
      message = "服务器升级中";
    }else if(e.error is SocketException){
      message = "网络未连接";
    } else {
      message = "Oops!!";
    }
  }
  toast(context, message);
//  Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
}

toast(BuildContext context, String msg) {
  Toast.show(msg, context,duration: 2);
}
