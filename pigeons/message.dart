import 'package:pigeon/pigeon.dart';

// ------------------------------------- 定义数据类型 -------------------------------------
class Book {
  int? id; // Initialization isn't supported for fields in Pigeon data classes
  String? title; // 不支持初始值，所以只能使用 nullable 类型，也即默认值都是 null
  Author? author; // 支持嵌套类
}

class Author {
  String? name;
  bool? male;
  StateEnum? state; // 支持枚举
}

enum StateEnum { success, error, unknown } // 枚举类

// ------------------------------------- 定义 native 方法 -------------------------------------

@HostApi() // 使用注解 @HostApi 修饰的方法，是在 native 中实现的，可以被 Flutter  调用的方法
abstract class TestBookApi {
  Book? search(String? keyword); // 支持可为空的参数或返回值
  List<Book> searchList(String keyword); // 也支持不可为空的参数或返回值
  List<Book?> searchList2(List<String?> keys); // 虽然定义的泛型参数 <String?> 可为空，但生产的代码仍是不可为空的
  void testNoArguments(); // 也支持没有参数或没有返回值
}

@HostApi()
abstract class TestAsyApi {
  @async
  String calculate(int key); //默认生成同步的 handlers，可以使用 @async 注解异步响应消息
}

@HostApi()
abstract class TestTaskQueueApi {
  @TaskQueue(type: TaskQueueType.serialBackgroundThread)
  // serialBackgroundThread: Handlers are invoked serially 连续的 on a background thread
  // serial: Handlers are invoked serially on the default thread. This is the value if unspecified
  int add(int x, int y);
}
// ------------------------------------- 定义 Flutter 方法 -------------------------------------

@FlutterApi() // 使用注解 @FlutterApi 修饰的方法，是在 Flutter  中实现的，可以被 native 调用的方法
abstract class TestFlutterApi {
  String getYourName(int key);
}
