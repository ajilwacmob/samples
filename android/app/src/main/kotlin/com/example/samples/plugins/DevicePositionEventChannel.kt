package com.example.samples.plugins

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

 class DevicePositionEventChannel:FlutterPlugin,MethodChannel.MethodCallHandler, SensorEventListener {

     private var channelName="com.example.samples.device_position_event_channel"
     private lateinit var context: Context
     private lateinit var eventChannel: EventChannel
     private var eventSink:EventChannel.EventSink?=null

     private var sensorManager: SensorManager? = null
     private var accelerometer: Sensor? = null


     override fun onSensorChanged(event: SensorEvent?) {
         if (event != null && eventSink != null) {
             val data = mapOf(
                     "x" to event.values[0],
                     "y" to event.values[1],
                     "z" to event.values[2]
             )
             eventSink?.success(data)
         }
     }

     override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {
         // No implementation needed for this example
     }


     override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
         eventChannel= EventChannel(binding.binaryMessenger,channelName)
         context=binding.applicationContext

         sensorManager = context.getSystemService(Context.SENSOR_SERVICE) as SensorManager
         accelerometer = sensorManager?.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)

         eventChannel.setStreamHandler(object :EventChannel.StreamHandler {
             override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                 eventSink = events
                 sensorManager?.registerListener(this@DevicePositionEventChannel, accelerometer, SensorManager.SENSOR_DELAY_NORMAL)
             }

             override fun onCancel(arguments: Any?) {
                 eventSink = null
                 sensorManager?.unregisterListener(this@DevicePositionEventChannel)
             }
         })
     }

     override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        eventChannel.setStreamHandler(null)
     }

     override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
         result.notImplemented()
     }
 }