import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

// This widget is the root of your application.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '标题'),
    );
  }
}

// This widget is the home page of your application
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title; // Fields in a Widget subclass are always marked "final"

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('com.bqt.test/base_channel');
  String _batteryLevel = '点击获取电量';
  int _counter = 0;

  void _incrementCounter() {
    setState(() => _counter++); // This call to setState causes rerun the build method below
    _getBatteryLevel().then((value) {
      debugPrint(value);
      setState(() => _batteryLevel = "$value 第 $_counter 次获取");
    });
  }

  Future<String> _getBatteryLevel() async {
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      return '电量 $result % .';
    } on PlatformException catch (e) {
      return "获取失败: '${e.message}'.";
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
    // The Flutter framework has been optimized to make rerunning build methods fast
    // you can just rebuild anything that needs updating rather than individually change instances of widgets
    return Scaffold(
      appBar: AppBar(
        // take the value from the MyHomePage object that was created by the MyApp.build method
        title: Text("这是${widget.title}"),
      ),
      // Center is a layout widget. It takes a single child and positions it in the middle of the parent
      body: Center(
        // Column is also a layout widget. It takes a list of children and arranges them vertically
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // center the children vertically
          children: <Widget>[
            const Text('这是一个 const Text'),
            Text('共点击了 $_counter 次\n$_batteryLevel'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _incrementCounter),
    );
  }
}
