import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    String? token,
    String? refreshToken,
  }) {
    _token = token;
    _refreshToken = refreshToken;
  }

  User.fromJson(dynamic json) {
    _token = json['token'];
    _refreshToken = json['refresh_token'];
  }

  String? _token;
  String? _refreshToken;

  User copyWith({
    String? token,
    String? refreshToken,
  }) =>
      User(
        token: token ?? _token,
        refreshToken: refreshToken ?? _refreshToken,
      );

  String? get token => _token;

  String? get refreshToken => _refreshToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;
    map['refresh_token'] = _refreshToken;
    return map;
  }
}
