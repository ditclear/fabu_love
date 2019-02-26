library model;

import 'package:json_annotation/json_annotation.dart';
part 'model.g.dart';

@JsonSerializable()
class Response {

  factory Response.fromJson(Map<String, dynamic> json) => _$ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseToJson(this);
  /**
   * success : true
   * data : {"teams":[{"_id":"5c3851c398e05136910dae88","name":"我的团队","role":"owner"}],"_id":"5c3851c398e05136910dae88","username":"ditclear","password":"$2b$10$PTlkKRx5FJQW/xlQrAXiwOwHOYspCiXNMliuojg5lTS3mkPzdu8vG","email":"ditclear@qq.com","__v":0,"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7Il9pZCI6IjVjMzg1MWMzOThlMDUxMzY5MTBkYWU4OCIsInVzZXJuYW1lIjoiZGl0Y2xlYXIiLCJlbWFpbCI6ImRpdGNsZWFyQHFxLmNvbSJ9LCJleHAiOjE1NTA2MzQ0NzUsImlhdCI6MTU1MDYzMDg3NX0.DdkioiDa5gtOS0JnO16_keFYnJZM1VLu7whCeuuhFEY"}
   */

  bool success;
  dynamic data;
  String message;

  Response();


}


@JsonSerializable()
class DataBean {
  /**
   * _id : "5c3851c398e05136910dae88"
   * username : "ditclear"
   * password : "$2b$10$PTlkKRx5FJQW/xlQrAXiwOwHOYspCiXNMliuojg5lTS3mkPzdu8vG"
   * email : "ditclear@qq.com"
   * token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7Il9pZCI6IjVjMzg1MWMzOThlMDUxMzY5MTBkYWU4OCIsInVzZXJuYW1lIjoiZGl0Y2xlYXIiLCJlbWFpbCI6ImRpdGNsZWFyQHFxLmNvbSJ9LCJleHAiOjE1NTA2MzQ0NzUsImlhdCI6MTU1MDYzMDg3NX0.DdkioiDa5gtOS0JnO16_keFYnJZM1VLu7whCeuuhFEY"
   * __v : 0
   * teams : [{"_id":"5c3851c398e05136910dae88","name":"我的团队","role":"owner"}]
   */

  @JsonKey(name: '_id')
  String id;
  String username;
  String password;
  String email;
  String token;
  int __v;
  List<TeamsListBean> teams;


  DataBean();

  factory DataBean.fromJson(Map<String, dynamic> json) => _$DataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DataBeanToJson(this);

}

@JsonSerializable()
class TeamsListBean {
  /**
   * _id : "5c3851c398e05136910dae88"
   * name : "我的团队"
   * role : "owner"
   */

  @JsonKey(name: '_id')
  String id;
  String name;
  String role;


  TeamsListBean();

  factory TeamsListBean.fromJson(Map<String, dynamic> json) => _$TeamsListBeanFromJson(json);

  Map<String, dynamic> toJson() => _$TeamsListBeanToJson(this);
}



