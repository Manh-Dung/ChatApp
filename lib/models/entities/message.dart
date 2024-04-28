import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

/// sender_id : "user_002@example.com"
/// content : "I'm doing well, thanks for asking!"
/// timestamp : "2023-04-28T10:16:45Z"

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message({
    String? senderId,
    String? content,
    Timestamp? timestamp,
  }) {
    _senderId = senderId;
    _content = content;
    _timestamp = timestamp;
  }

  Message.fromJson(dynamic json) {
    _senderId = json['sender_id'];
    _content = json['content'];
    _timestamp = json['timestamp'];
  }

  String? _senderId;
  String? _content;
  Timestamp? _timestamp;

  Message copyWith({
    String? senderId,
    String? content,
    Timestamp? timestamp,
  }) =>
      Message(
        senderId: senderId ?? _senderId,
        content: content ?? _content,
        timestamp: timestamp ?? _timestamp,
      );

  String? get senderId => _senderId;

  String? get content => _content;

  Timestamp? get timestamp => _timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sender_id'] = _senderId;
    map['content'] = _content;
    map['timestamp'] = _timestamp;
    return map;
  }
}
