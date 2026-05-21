import 'package:flutter/material.dart';

class NetworkErrorManager {
  static final ValueNotifier<String?> connectionErrorNotifier = ValueNotifier<String?>(null);

  static void reportError(String message) {
    final msg = message.toLowerCase();
    if (msg.contains('اتصال') ||
        msg.contains('connection') ||
        msg.contains('internet') ||
        msg.contains('offline') ||
        msg.contains('مهلة') ||
        msg.contains('timeout') ||
        msg.contains('time out')) {
      connectionErrorNotifier.value = message;
    }
  }

  static void clearError() {
    connectionErrorNotifier.value = null;
  }
}
