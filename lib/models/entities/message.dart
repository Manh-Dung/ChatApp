import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

/// sender_id : ""
/// content : ""
/// send_at : ""

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message({
    String? senderId,
    String? content,
    Timestamp? sendAt,
  }) {
    _senderId = senderId;
    _content = content;
    _sendAt = sendAt;
  }

  Message.fromJson(dynamic json) {
    _senderId = json['sender_id'];
    _content = json['content'];
    _sendAt = json['send_at'];
  }

  String? _senderId;
  String? _content;
  Timestamp? _sendAt;

  Message copyWith({
    String? senderId,
    String? content,
    Timestamp? sendAt,
  }) =>
      Message(
        senderId: senderId ?? _senderId,
        content: content ?? _content,
        sendAt: sendAt ?? _sendAt,
      );

  String? get senderId => _senderId;

  String? get content => _content;

  Timestamp? get sendAt => _sendAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sender_id'] = _senderId;
    map['content'] = _content;
    map['send_at'] = _sendAt;
    return map;
  }
}
