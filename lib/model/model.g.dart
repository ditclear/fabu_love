// GENERATED CODE - DO NOT MODIFY BY HAND

part of model;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Response _$ResponseFromJson(Map<String, dynamic> json) {
  return Response()
    ..success = json['success'] as bool
    ..data = json['data'] ?? null
    ..message = json['message'] as String;
}

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message
    };

DataBean _$DataBeanFromJson(Map<String, dynamic> json) {
  return DataBean()
    ..id = json['_id'] as String
    ..username = json['username'] as String
    ..password = json['password'] as String
    ..email = json['email'] as String
    ..token = json['token'] as String
    ..teams = (json['teams'] as List)
        ?.map((e) => e == null
            ? null
            : TeamsListBean.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$DataBeanToJson(DataBean instance) => <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'password': instance.password,
      'email': instance.email,
      'token': instance.token,
      'teams': instance.teams
    };

TeamsListBean _$TeamsListBeanFromJson(Map<String, dynamic> json) {
  return TeamsListBean()
    ..id = json['_id'] as String
    ..name = json['name'] as String
    ..role = json['role'] as String;
}

Map<String, dynamic> _$TeamsListBeanToJson(TeamsListBean instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'role': instance.role
    };
