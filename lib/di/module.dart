import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:fabu_love/helper/net_utils.dart';
import 'package:fabu_love/helper/constants.dart';
import 'package:fabu_love/helper/shared_preferences.dart';
import 'package:fabu_love/model/remote.dart';
import 'package:fabu_love/model/repo.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:fabu_love/viewmodel.dart';

SpUtil spUtil;
final Dio dio=Dio()
                ..options = BaseOptions(
                    baseUrl: 'https://fabu.love/api/',
                    connectTimeout: 30,
                    receiveTimeout: 30)
                ..interceptors.add(HeaderInterceptor())
                ..interceptors.add(CookieManager(CookieJar()))
                ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true));


void init() async {
  spUtil = await SpUtil.getInstance();
}

AuthService _provideAuthService() => AuthService();

AppService _provideAppService() => AppService();

AuthRepo provideAuthRepo() => AuthRepo(_provideAuthService(), spUtil);

AppRepo provideAppRepo() => AppRepo(_provideAppService());

final providers = Providers()
                    ..provideValue(CountViewModel());

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


