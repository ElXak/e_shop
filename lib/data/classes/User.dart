import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

// Run below command to generate User.g.dart file
// flutter packages pub run build_runner build

@JsonSerializable()
class User {
  User({
    this.id,
    this.login,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
    this.gender,
    this.birthDate,
    this.phoneNumber,
    this.address,
    this.mailbox,
    // this.token,
    this.city,
    this.zipCode,
  });

  @JsonKey(name: 'ID')
  final String id;

  @JsonKey(name: 'LOGIN')
  final String login;

  @JsonKey(name: 'EMAIL')
  final String email;

  @JsonKey(name: 'NAME', nullable: true)
  final String firstName;

  @JsonKey(name: 'LAST_NAME', nullable: true)
  final String lastName;

  @JsonKey(name: 'PERSONAL_PHOTO', nullable: true)
  final String avatar;

  @JsonKey(name: 'PERSONAL_GENDER', nullable: true)
  final String gender;

  @JsonKey(name: 'PERSONAL_BIRTHDATE', nullable: true)
  final DateTime birthDate;

  @JsonKey(name: 'PERSONAL_PHONE', nullable: true)
  final String phoneNumber;

  @JsonKey(name: 'PERSONAL_STREET', nullable: true)
  final String address;

  @JsonKey(name: 'PERSONAL_MAILBOX', nullable: true)
  final String mailbox;

  @JsonKey(name: 'PERSONAL_CITY', nullable: true)
  final String city;

  @JsonKey(name: 'PERSONAL_ZIP', nullable: true)
  final String zipCode;

  // String token;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return '$firstName $lastName'.toString();
  }
}
