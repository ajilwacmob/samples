package com.example.samples.plugins

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

 class BatteryEventChannel: FlutterPlugin, MethodChannel.MethodCallHandler  {

  private var channelName="com.example.samples.battery_event_channel"

  private lateinit var context:Context
  private var eventSink: EventChannel.EventSink? = null
  private lateinit var eventChannel: EventChannel


  private val batteryReceiver = object : BroadcastReceiver() {
   override fun onReceive(context: Context, intent: Intent) {
    val level = intent.getIntExtra("level", -1)
    print("updating")
    eventSink?.success(level)
   }
  }

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
   eventChannel=EventChannel(binding.binaryMessenger,channelName)
   context=binding.applicationContext

   eventChannel.setStreamHandler(object : EventChannel.StreamHandler {
    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
     eventSink = events
     registerBatteryReceiver()
    }

    override fun onCancel(arguments: Any?) {
     eventSink = null
     unregisterBatteryReceiver()
    }
   })
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
   eventChannel.setStreamHandler(null)
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
   result.notImplemented()
  }

  private fun registerBatteryReceiver() {
   val intentFilter = IntentFilter(Intent.ACTION_BATTERY_CHANGED)
   context.registerReceiver(batteryReceiver, intentFilter)
  }

  private fun unregisterBatteryReceiver() {
   context.unregisterReceiver(batteryReceiver)
  }
 }