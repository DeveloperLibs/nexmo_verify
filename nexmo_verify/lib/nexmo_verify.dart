import 'dart:async';

import 'package:flutter/services.dart';

class NexmoVerify {
  static const MethodChannel _channel =
      const MethodChannel('nexmo_verify');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
