import 'package:flutter/material.dart';
import 'flutter_api.dart';
import 'pigeon.dart';

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
  int _counter = 0;
  TestBookApi api = TestBookApi(); // 注意，引用的是 lib/pigeon.dart 下的类，而不是 pigeons 目录下的
  TestAsyApi asyApi = TestAsyApi();

  @override
  void initState() {
    super.initState();
    TestFlutterApi.setup(TestFlutterApiImpl()); // 同样需要在使用前注入 method channel
  }

  void _incrementCounter() {
    setState(() => _counter++); // This call to setState causes rerun the build method below
    callNativeMethod(); // 在合适的时机调用 method channel
  }

  void callNativeMethod() {
    if (_counter % 5 == 0) {
      api.search("哈哈").then((book) {
        if (book != null) {
          debugPrint("查询结果：${book.id} - ${book.title}");
          Author? author = book.author;
          if (author != null) {
            debugPrint("作者信息：${author.name} - ${author.male} - ${author.state}");
          }
        }
      });
    } else if (_counter == 1) {
      api.searchList("哈哈哈").then((list) => debugPrint("返回数量 ${list.length}"));
    } else if (_counter == 2) {
      api.searchList2(["啊", "哈"]).then((list) => debugPrint("返回数量 ${list.length}"));
    } else if (_counter == 3) {
      api.testNoArguments();
    } else {
      asyApi.calculate(10088).then((value) => debugPrint("返回值为 $value"));
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
            Text('共点击了 $_counter 次'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _incrementCounter),
    );
  }
}
