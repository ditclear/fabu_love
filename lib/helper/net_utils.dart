import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fabu_love/di/module.dart';
import 'package:fabu_love/helper/constants.dart';
import 'package:fabu_love/model/model.dart' as model;
import 'package:rxdart/rxdart.dart';

Future<model.Response> _get(String url, {Map<String, dynamic> params}) async {
  var response = await dio.get(url, queryParameters: params);
  return model.Response.fromJson(response.data);
}

Observable<model.Response> post(String url, Map<String, dynamic> params) =>
    Observable.fromFuture(_post(url, params)).asBroadcastStream();

Observable<model.Response> get(String url, {Map<String, dynamic> params}) =>
    Observable.fromFuture(_get(url,params: params)).asBroadcastStream();

Future<model.Response> _post(String url, Map<String, dynamic> params) async {
  var response = await dio.post(url, data: params);
  return model.Response.fromJson(response.data);
}

class HeaderInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options) {
    final token = spUtil.getString(KEY_TOKEN);
    if (token != null && token.length > 0) {
      options.headers.putIfAbsent('Authorization', () => token);
    }
    return super.onRequest(options);
  }
}

class ApiException extends Error {
  final int code;
  final String message;

  ApiException(this.code, this.message);
}
