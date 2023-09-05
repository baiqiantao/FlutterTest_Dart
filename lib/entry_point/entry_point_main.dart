import 'package:flutter/material.dart';

@pragma('vm:entry-point')
void main() => runApp(const MyApp(color: Colors.red));

@pragma('vm:entry-point')
void greenMain() => runApp(const MyApp(color: Colors.green));

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text('main 是红色，greenMain 是绿色')],
        ),
      ),
    );
  }
}
