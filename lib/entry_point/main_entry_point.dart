import 'package:flutter/material.dart';
import '/entry_point/home_page_state.dart';

// 可以通过以下方法指定应用程序的【入口文件名】
// flutter run --target=lib/entry_point/main_entry_point.dart

// 可以通过以下方法指定应用程序的【入口方法名】
// val pathToBundle = FlutterInjector.instance().flutterLoader().findAppBundlePath()
// DartExecutor.DartEntrypoint(pathToBundle, entrypoint) // entrypoint 即为入口方法名

// 可以通过以下方法指定应用程序的【启动参数】
//通过【flutter run --dart-define=key=value】传值，并通过【String/int/bool.fromEnvironment】取值
//通过【flutter run --dart-entrypoint-args xxx】传值，并通过【main 的 args 参数】取值 -- 移动端不支持

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
