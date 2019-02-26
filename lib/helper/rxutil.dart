import 'dart:convert';
import 'package:fabu_love/model/model.dart';
import 'package:fabu_love/helper/exceptions.dart';

getOrigin<T>(Response response)  {
  if (!response.success) {
    throw response.message;
  }
}
