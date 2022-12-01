import 'dart:convert';

import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  final String password;
  final String username;
  const AuthModel({
    required this.username,
    required this.password,
  });

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source));

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      username: map['username'] ?? '',
      password: map['password'] ?? '',
    );
  }

  @override
  List<Object?> get props => [username, password];

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  String toJson() => json.encode(toMap());
}
