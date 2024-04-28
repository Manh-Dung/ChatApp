import 'dart:convert';

import 'message.dart';

/// id : "conversation_001"
/// participants : ["user_001@example.com","user_002@example.com"]
/// messages : [{"senderId":"user_001@example.com","content":"Hello, how are you?","timestamp":"2023-04-28T10:15:30Z"},{"sender":"user_002@example.com","content":"I'm doing well, thanks for asking!","timestamp":"2023-04-28T10:16:45Z"},{"sender":"user_001@example.com","content":"That's great to hear!","timestamp":"2023-04-28T10:17:20Z"}]

Chat chatFromJson(String str) => Chat.fromJson(json.decode(str));

String chatToJson(Chat data) => json.encode(data.toJson());

class Chat {
  Chat({
    String? id,
    List<String>? participants,
    List<Message>? messages,
  }) {
    _id = id;
    _participants = participants;
    _messages = messages;
  }

  Chat.fromJson(dynamic json) {
    _id = json['id'];
    _participants =
        json['participants'] != null ? json['participants'].cast<String>() : [];
    if (json['messages'] != null) {
      _messages = [];
      json['messages'].forEach((v) {
        _messages?.add(Message.fromJson(v));
      });
    }
  }

  String? _id;
  List<String>? _participants;
  List<Message>? _messages;

  Chat copyWith({
    String? id,
    List<String>? participants,
    List<Message>? messages,
  }) =>
      Chat(
        id: id ?? _id,
        participants: participants ?? _participants,
        messages: messages ?? _messages,
      );

  String? get id => _id;

  List<String>? get participants => _participants;

  List<Message>? get messages => _messages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['participants'] = _participants;
    if (_messages != null) {
      map['messages'] = _messages?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
