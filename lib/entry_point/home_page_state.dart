import 'package:flutter/material.dart';
import '/entry_point/entry_point_main.dart';

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.mTitle)),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('main 是红色，greenMain 是绿色')],
        ),
      ),
    );
  }
}