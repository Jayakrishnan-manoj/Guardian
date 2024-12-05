package com.jayk.guardian

import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterFragmentActivity() {
    private lateinit var channel: MethodChannel

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        // channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "autofill_channel")
        // channel.setMethodCallHandler { call, result ->
        //     when (call.method) {
        //         "getPasswordsForPackage" -> {
        //             // Instead of querying a separate database, we'll send the request back to Flutter
        //             val packageName = call.arguments as? String
        //             if (packageName != null) {
        //                 // Flutter side will handle the actual database query
        //                 result.success(packageName)
        //             } else {
        //                 result.error("INVALID_ARGUMENT", "Package name is required", null)
        //             }
        //         }
        //         else -> result.notImplemented()
        //     }
        // }
    }
}