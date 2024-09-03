import 'dart:convert';

import 'package:equatable/equatable.dart';

UserSession userSessionFromJson(String str) =>
    UserSession.fromJson(json.decode(str));

String userSessionToJson(UserSession data) => json.encode(data.toJson());

class UserSession extends Equatable {
  final String? message;
  final String accessToken;
  final String? refreshToken;

  const UserSession({
    this.message,
    required this.accessToken,
    this.refreshToken,
  });

  UserSession copyWith({
    String? message,
    String? accessToken,
    String? refreshToken,
  }) =>
      UserSession(
        message: message ?? this.message,
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
      );

  factory UserSession.fromJson(Map<String, dynamic> json) => UserSession(
        message: json["message"],
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "access_token": accessToken,
        "refresh_token": refreshToken,
      };

  @override
  List<Object?> get props => [message, accessToken, refreshToken];
}
