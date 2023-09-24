import 'package:flutter/material.dart';
import 'package:qt_flutter_test/channel/pigeon.dart';

class TestFlutterApiImpl extends TestFlutterApi {
  @override
  String getYourName(int key) {
    debugPrint("Flutter 收到 native 的请求：$key");
    return "结果$key";
  }
}
