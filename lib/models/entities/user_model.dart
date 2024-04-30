import 'dart:convert';

/// name : ""
/// email : ""
/// uid : ""
/// image_url : ""

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    String? name,
    String? email,
    String? uid,
    String? imageUrl,
  }) {
    _name = name;
    _email = email;
    _uid = uid;
    _imageUrl = imageUrl;
  }

  UserModel.fromJson(dynamic json) {
    _name = json['name'];
    _email = json['email'];
    _uid = json['uid'];
    _imageUrl = json['image_url'];
  }

  String? _name;
  String? _email;
  String? _uid;
  String? _imageUrl;

  UserModel copyWith({
    String? name,
    String? email,
    String? uid,
    String? imageUrl,
  }) =>
      UserModel(
        name: name ?? _name,
        email: email ?? _email,
        uid: uid ?? _uid,
        imageUrl: imageUrl ?? _imageUrl,
      );

  String? get name => _name;

  String? get email => _email;

  String? get uid => _uid;

  String? get imageUrl => _imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['email'] = _email;
    map['uid'] = _uid;
    map['image_url'] = _imageUrl;
    return map;
  }
}
