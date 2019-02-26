import 'dart:convert';

import 'package:fabu_love/helper/constants.dart';
import 'package:fabu_love/helper/rxutil.dart';
import 'package:fabu_love/helper/shared_preferences.dart';
import 'package:fabu_love/model/app.dart';
import 'package:fabu_love/model/model.dart';
import 'package:fabu_love/model/remote.dart';
import 'package:rxdart/rxdart.dart';

class AuthRepo {
  final AuthService _remote;
  final SpUtil _spUtil;

  AuthRepo(this._remote, this._spUtil);

  Observable<DataBean> login(Map<String, dynamic> map) =>
      _remote.login(map).doOnListen(() {
        _spUtil.remove(KEY_TOKEN);
      }).map((response) {
        getOrigin(response);
        return DataBean.fromJson(response.data);
      }).doOnData(_cacheUser);

  _cacheUser(DataBean user) {
    _spUtil.putString(KEY_USER, jsonEncode(user.toJson()));
    _spUtil.putString(KEY_TOKEN, "Bearer " + user.token);
  }
}

class AppRepo {
  final AppService _remote;

  AppRepo(this._remote);

  Observable<List<AppListBean>> getAppListByTeamId(String teamId) =>
      _remote.getAppListByTeamId(teamId).map((response) {
        getOrigin(response);
        return AppListBean.fromMapList(response.data);
      });
}
