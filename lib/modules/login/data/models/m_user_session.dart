import 'dart:convert';

import 'package:equatable/equatable.dart';

UserSession userSessionFromJson(String str) =>
    UserSession.fromJson(json.decode(str));

String userSessionToJson(UserSession data) => json.encode(data.toJson());

class UserSession extends Equatable {
  final String? username;
  final String accessToken;
  final String? role;

  const UserSession({
    this.username,
    required this.accessToken,
    this.role,
  });

  UserSession copyWith({
    String? username,
    String? accessToken,
    String? role,
  }) =>
      UserSession(
        username: username ?? this.username,
        accessToken: accessToken ?? this.accessToken,
        role: role ?? this.role,
      );

  factory UserSession.fromJson(Map<String, dynamic> json) => UserSession(
        username: json["username"],
        accessToken: json["access_token"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "access_token": accessToken,
        "role": role,
      };

  @override
  List<Object?> get props => [username, accessToken, role];
}
