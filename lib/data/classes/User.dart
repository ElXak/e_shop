import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.avatar,
    this.token,
    this.phoneNumber,
    this.address,
    this.address2,
  });

  final int id;

  final String firstName;
  final String lastName;
  final String avatar;
  String token;
  String phoneNumber;
  String address;
  String address2;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return '$firstName $lastName'.toString();
  }
}
