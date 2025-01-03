import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BatteryService {
  BatteryService._();

  static final BatteryService _intance = BatteryService._();

  static BatteryService get instance => _intance;

  static String channelName = "com.example.samples.battery_event_channel";

  final EventChannel _eventChannel = EventChannel(channelName);

  ValueNotifier<String> batteryNotifier =
      ValueNotifier("Waiting for battery level...");

  void startListeningToBattery() {
    _eventChannel.receiveBroadcastStream().listen((event) {
      batteryNotifier.value = 'Battery level: ${event.toString()}%';
    }, onError: (error) {
      batteryNotifier.value = 'Error: ${error.toString()}';
    });
  }
}
