// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['id'] as int,
    json['username'] as String,
    json['usertoken'] as String,
    json['create_time'] as String,
    json['update_time'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'usertoken': instance.usertoken,
      'create_time': instance.createTime,
      'update_time': instance.updateTime,
    };
