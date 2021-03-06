import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';


@JsonSerializable()
class User extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'username')
  String username;

  @JsonKey(name: 'usertoken')
  String usertoken;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'avater')
  String avater;

  @JsonKey(name: 'latitude')
  String latitude;

  @JsonKey(name: 'longitude')
  String longitude;

  @JsonKey(name: 'create_time')
  String createTime;

  @JsonKey(name: 'update_time')
  String updateTime;

  User(this.id,this.username,this.usertoken,this.nickname,this.avater,this.latitude,this.longitude,this.createTime,this.updateTime,);

  factory User.fromJson(Map<String, dynamic> srcJson) => _$UserFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserToJson(this);

}