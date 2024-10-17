package com.example.guardian

//import com.example.guardian.Password
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterFragmentActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine){
        super.configureFlutterEngine(flutterEngine)
        // MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "autofill_channel").setMethodCallHandler{call, result ->
        //     when(call.method){
        //         "getPasswordsForPackage" -> {
        //             val packageName = call.arguments as? String

        //             val passwords: List<Password> = queryPasswordsFromIsarDB(packageName)
        //             result.success(passwords.map {it.toMap()})
        //         }
        //         "savePassword" -> {
        //             val passwordMap = call.arguments as? Map<String, Any>
        //             if (passwordMap != null) {
        //                 val password = Password.fromMap(passwordMap)
        //                 // Save the password to IsarDB
        //                 savePasswordToIsarDB(password)
        //                 result.success(null)
        //             } else {
        //                 result.error("INVALID_ARGUMENT", "Invalid password data", null)
        //             }
        //         }
        //         else -> result.notImplemented()

        //     }
        
        // }
    }
}