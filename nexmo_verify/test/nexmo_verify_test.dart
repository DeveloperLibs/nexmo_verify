import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexmo_verify/nexmo_verify.dart';

void main() {
  const MethodChannel channel = MethodChannel('nexmo_verify');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await NexmoVerify.platformVersion, '42');
  });
}
