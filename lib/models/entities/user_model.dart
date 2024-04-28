import 'dart:convert';

/// name : ""
/// email : ""
/// uid : ""

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    String? name,
    String? email,
    String? uid,
  }) {
    _name = name;
    _email = email;
    _uid = uid;
  }

  UserModel.fromJson(dynamic json) {
    _name = json['name'];
    _email = json['email'];
    _uid = json['uid'];
  }

  String? _name;
  String? _email;
  String? _uid;

  UserModel copyWith({
    String? name,
    String? email,
    String? uid,
  }) =>
      UserModel(
        name: name ?? _name,
        email: email ?? _email,
        uid: uid ?? _uid,
      );

  String? get name => _name;

  String? get email => _email;

  String? get uid => _uid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['email'] = _email;
    map['uid'] = _uid;
    return map;
  }
}
