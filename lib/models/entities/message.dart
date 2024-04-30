import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

/// sender_id : ""
/// content : ""
/// send_at : ""
/// messageType : ""

enum MessageType { Text, Image }

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message({
    String? senderId,
    String? content,
    Timestamp? sendAt,
    MessageType? messageType,
  }) {
    _senderId = senderId;
    _content = content;
    _sendAt = sendAt;
    _messageType = messageType;
  }

  Message.fromJson(dynamic json) {
    _senderId = json['sender_id'];
    _content = json['content'];
    _sendAt = json['send_at'];
    _messageType = MessageType.values.byName(json['messageType']);
  }

  String? _senderId;
  String? _content;
  Timestamp? _sendAt;
  MessageType? _messageType;

  Message copyWith({
    String? senderId,
    String? content,
    Timestamp? sendAt,
    MessageType? messageType,
  }) =>
      Message(
        senderId: senderId ?? _senderId,
        content: content ?? _content,
        sendAt: sendAt ?? _sendAt,
        messageType: messageType ?? _messageType,
      );

  String? get senderId => _senderId;

  String? get content => _content;

  Timestamp? get sendAt => _sendAt;

  MessageType? get messageType => _messageType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sender_id'] = _senderId;
    map['content'] = _content;
    map['send_at'] = _sendAt;
    map['messageType'] = _messageType?.name;
    return map;
  }
}
