import 'dart:developer';

import 'package:flutter/foundation.dart';

var logger = MyLogger();

class MyLogger {
  /// Log a message at level verbose.
  void v(dynamic message) {
    _log("🤍 VERBOSE: $message");
  }

  /// Log a message at level debug.
  void d(dynamic message) {
    _log("💙 DEBUG: $message");
  }

  /// Log a message at level info.
  void i(dynamic message) {
    _log("❤️ INFO: $message");
  }

  /// Log a message at level warning.
  void w(dynamic message) {
    _log("💛 WARNING: $message");
  }

  /// Log a message at level error.
  void e(dynamic message) {
    _log("❤️ ERROR: $message");
  }

  void _log(dynamic message) {
    if (kDebugMode) {
      print("$message");
    }
  }

  /// Log a long message
  void long(dynamic message) {
    log(message);
  }
}
