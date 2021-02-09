// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as int,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    avatar: json['avatar'] as String,
    token: json['token'] as String,
    phoneNumber: json['phoneNumber'] as String,
    address: json['address'] as String,
    address2: json['address2'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'avatar': instance.avatar,
      'token': instance.token,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'address2': instance.address2,
    };
