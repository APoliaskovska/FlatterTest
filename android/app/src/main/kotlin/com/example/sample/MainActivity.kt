package com.example.sample

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.android.FlutterEngine
import io.flutter.embedding.android.FlutterRegistrant

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine){
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }
}
