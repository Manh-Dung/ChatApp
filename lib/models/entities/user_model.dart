import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    String? name,
    String? uid,
  }) {
    _name = name;
    _uid = uid;
  }

  UserModel.fromJson(dynamic json) {
    _name = json['name'];
    _uid = json['uid'];
  }

  String? _name;
  String? _uid;

  UserModel copyWith({
    String? name,
    String? uid,
  }) =>
      UserModel(
        name: name ?? _name,
        uid: uid ?? _uid,
      );

  String? get name => _name;

  String? get uid => _uid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['uid'] = _uid;
    return map;
  }
}
