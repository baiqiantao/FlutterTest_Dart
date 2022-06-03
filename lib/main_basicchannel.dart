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

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const BasicMessageChannel<String> _channel = BasicMessageChannel('com.bqt.test/basic_channel', StringCodec());
  String _message = "message";
  String _response = "response";

  @override
  void initState() {
    super.initState();
    debugPrint("initState");
    _channel.setMessageHandler((String? message) async {
      debugPrint("message: $message"); // 收到的 native 发送的消息
      _message = message ?? "null";
      setState(() => _message);
      return '已收到【$message】'; // 对 native 的响应
    });
  }

  void _request() async {
    final String? response = await _channel.send('来自 Dart 的请求'); // 对 native 发起请求
    debugPrint("response: $response"); // 收到的 native 响应
    _response = response ?? "null";
    setState(() => _response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_response),
            Text(_message),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _request),
    );
  }
}
