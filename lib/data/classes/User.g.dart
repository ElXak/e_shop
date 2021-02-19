// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['ID'] as String,
    login: json['LOGIN'] as String,
    email: json['EMAIL'] as String,
    firstName: json['NAME'] as String,
    lastName: json['LAST_NAME'] as String,
    avatar: json['PERSONAL_PHOTO'] as String,
    gender: json['PERSONAL_GENDER'] as String,
    birthDate: json['PERSONAL_BIRTHDATE'] == null
        ? null
        : DateTime.parse(json['PERSONAL_BIRTHDATE'] as String),
    phoneNumber: json['PERSONAL_PHONE'] as String,
    address: json['PERSONAL_STREET'] as String,
    mailbox: json['PERSONAL_MAILBOX'] as String,
    city: json['PERSONAL_CITY'] as String,
    zipCode: json['PERSONAL_ZIP'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'ID': instance.id,
      'LOGIN': instance.login,
      'EMAIL': instance.email,
      'NAME': instance.firstName,
      'LAST_NAME': instance.lastName,
      'PERSONAL_PHOTO': instance.avatar,
      'PERSONAL_GENDER': instance.gender,
      'PERSONAL_BIRTHDATE': instance.birthDate?.toIso8601String(),
      'PERSONAL_PHONE': instance.phoneNumber,
      'PERSONAL_STREET': instance.address,
      'PERSONAL_MAILBOX': instance.mailbox,
      'PERSONAL_CITY': instance.city,
      'PERSONAL_ZIP': instance.zipCode,
    };
