import 'package:flutter/material.dart';
import '/entry_point/home_page_state.dart';

// 以下方法可以指定应用程序的入口文件名和入口方法名，但是亲测后确认无效！
// flutter run --target=lib/entry_point/entry_point_main.dart --dart-define=main=greenMain
@pragma('vm:entry-point')
void greenMain() => runApp(const MyApp(mColor: Colors.green));

@pragma('vm:entry-point')
void main() => runApp(const MyApp(mColor: Colors.red));

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.mColor});

  final MaterialColor mColor;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      theme: ThemeData(primarySwatch: mColor),
      home: const MyHomePage(mTitle: '演示 vm:entry-point'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.mTitle});

  final String mTitle;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}
