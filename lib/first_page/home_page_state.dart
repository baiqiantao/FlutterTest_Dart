import 'package:flutter/material.dart';

import 'main_first_page.dart';

class MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  int _counter = 0;

  void _incrementCounter() => setState(() => _counter++);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(child: Text('已点击 $_counter 次')),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: Text('$_counter'),
      ));

  @override
  void initState() {
    super.initState();
    debugPrint("initState");
    WidgetsBinding.instance.addObserver(this); // 注册监听器
    WidgetsBinding.instance.addPostFrameCallback((_) => debugPrint("单次 Frame 绘制回调"));
    //WidgetsBinding.instance.addPersistentFrameCallback((_) => debugPrint("Frame 绘制回调")); // 每帧都回调
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("dispose");
    WidgetsBinding.instance.removeObserver(this); // 移除监听器
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async => debugPrint("$state");
}
