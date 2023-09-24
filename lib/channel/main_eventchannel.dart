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

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const _methodChannel = MethodChannel('com.bqt.test/method_channel');
  static const _eventChannel = EventChannel('com.bqt.test/enent_channel');
  StreamSubscription? _streamSubscription;

  String _millisUntilFinished = "默认值";
  String _state = "默认值";
  bool _hasStart = false;

  @override
  void initState() {
    super.initState();
    debugPrint("initState");
    _streamSubscription = _eventChannel.receiveBroadcastStream().listen((data) {
      debugPrint("返回值: $data");
      _millisUntilFinished = data;
      setState(() => _millisUntilFinished);
    }, onError: (error) {
      debugPrint("onError : ${error.runtimeType} ${error.toString()}");
    }, onDone: () {
      debugPrint("onDone");
    }, cancelOnError: false); // 遇到错误时是否自动结束监听
  }

  void _pauseOrResume() {
    StreamSubscription? temp = _streamSubscription;
    if (temp != null) {
      if (temp.isPaused) {
        debugPrint("resume");
        _streamSubscription?.resume(); // Resumes after a pause
      } else {
        debugPrint("pause"); // pause 后，客户端发送的数据会在 resume 时一次性全部补发回来
        _streamSubscription?.pause(); // Requests that the stream pauses events until further notice
        //_streamSubscription?.cancel(); // Cancels this subscription
      }
    }
  }

  void _startOrStop() {
    _callStartOrStop().then((value) {
      debugPrint("返回值: $value");
      _state = value;
      setState(() => _state);
    });
    _hasStart = !_hasStart;
  }

  Future<String> _callStartOrStop() async {
    try {
      if (_hasStart) {
        return await _methodChannel.invokeMethod('stopTimer');
      } else {
        return await _methodChannel.invokeMethod('startTimer');
      }
    } on PlatformException catch (e) {
      return "Exception: ${e.message}";
    }
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
            Text(_state),
            Text(_millisUntilFinished),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _startOrStop),
      bottomNavigationBar: FloatingActionButton(onPressed: _pauseOrResume),
    );
  }
}
