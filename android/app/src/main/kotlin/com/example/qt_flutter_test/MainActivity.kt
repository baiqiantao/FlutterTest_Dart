package com.example.qt_flutter_test

import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: android.os.Bundle?) {
        intent.putExtra(io.flutter.embedding.engine.FlutterShellArgs.ARG_KEY_DISABLE_SERVICE_AUTH_CODES, true) // 禁用 auth_code
        intent.putExtra(io.flutter.embedding.engine.FlutterShellArgs.ARG_KEY_OBSERVATORY_PORT, 9999) // 写死端口
        super.onCreate(savedInstanceState)
    }

    override fun onResume() {
        super.onResume()
        Toast.makeText(this, "onResume", Toast.LENGTH_SHORT).show()
    }
}