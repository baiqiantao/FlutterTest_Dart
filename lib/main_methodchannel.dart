import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: '演示 MethodChannel'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('com.bqt.test/base_channel');
  String _batteryLevel = '';
  int _counter = 0;

  void _incrementCounter() {
    setState(() => _counter++); // This call to setState causes rerun the build method below
    _getBatteryLevel().then((value) {
      debugPrint(value);
      setState(() => _batteryLevel = value);
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('这是标题')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('电量 $_batteryLevel'),
              Text('点击次数 $_counter'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: _incrementCounter),
      ),
    );
  }
}
