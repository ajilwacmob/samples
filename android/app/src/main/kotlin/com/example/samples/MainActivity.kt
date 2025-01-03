package com.example.samples
import com.example.samples.plugins.AmbientEventChannel
import com.example.samples.plugins.BatteryEventChannel
import com.example.samples.plugins.DevicePositionEventChannel
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity(){

    override fun  configureFlutterEngine(flutterEngine: FlutterEngine) {

        flutterEngine.plugins.add(BatteryEventChannel());
        flutterEngine.plugins.add(DevicePositionEventChannel());
        super.configureFlutterEngine(flutterEngine);
    }
}
