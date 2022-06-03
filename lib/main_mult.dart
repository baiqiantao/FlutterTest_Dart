import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

void main() => runApp(const MyApp(color: Colors.red));

@pragma('vm:entry-point')
void topMain() => runApp(const MyApp(color: Colors.green));

@pragma('vm:entry-point')
void bottomMain() => runApp(const MyApp(color: Colors.blue));

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.color});

  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: color),
      home: const MyHomePage(title: '演示 MultFlutter'),
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
  int _counter = 0;
  final _url = Uri.parse('https://www.cnblogs.com/baiqiantao/');
  final MethodChannel _channel = const MethodChannel('multiple-flutters');

  @override
  void initState() {
    super.initState();
    _channel.setMethodCallHandler((call) async {
      if (call.method == "setData") {
        _counter = call.arguments as int;
        setState(() => _counter);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('当前的值为：$_counter'),
            ElevatedButton(
              child: const Text('将当前值 +1'),
              onPressed: () => _channel.invokeMethod<void>("incrementCount", _counter),
            ),
            ElevatedButton(
              child: const Text('跳到一个 native 页面'),
              onPressed: () => _channel.invokeMethod<void>("next", _counter),
            ),
            ElevatedButton(
              child: const Text('使用浏览器打开一个 url'),
              onPressed: () async {
                if (await launcher.canLaunchUrl(_url)) {
                  await launcher.launchUrl(_url);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
