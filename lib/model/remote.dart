import 'package:fabu_love/helper/net_utils.dart';

import 'model.dart';
import 'package:rxdart/rxdart.dart';

class AuthService {
  Observable<Response> login(Map<String, dynamic> map) => post('user/login', map);
}

class AppService {
  Observable<Response> getAppListByTeamId(String id) =>  get("apps/$id");
}
