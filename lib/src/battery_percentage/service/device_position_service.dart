import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class DevicePositionService {
  DevicePositionService._();

  static final DevicePositionService _instance = DevicePositionService._();

  static DevicePositionService get instance => _instance;

  static const String channelName =
      "com.example.samples.device_position_event_channel";

  final EventChannel _eventChannel = const EventChannel(channelName);

  double alpha = 0.8; // Smoothing factor
  double? lastX, lastY, lastZ;

  ValueNotifier<dynamic> devicePosNotifier = ValueNotifier<dynamic>({});

  void startListeningToSensor() {
    if (Platform.isIOS) return;
    _eventChannel.receiveBroadcastStream().listen((event) {
      // if (devicePosNotifier.value['x'] != event['x'] &&
      //     devicePosNotifier.value['y'] != event['y'] &&
      //     devicePosNotifier.value['z'] != event['z']) {
      devicePosNotifier.value = event;
      // applyLowPassFilter(event);
      //}
    }, onError: (error) {
      devicePosNotifier.value = 'Error: $error';
    });
  }

  void applyLowPassFilter(dynamic data) {
    var x = alpha * (lastX ?? data['x']) + (1 - alpha) * data['x'];
    var y = alpha * (lastY ?? data['y']) + (1 - alpha) * data['y'];
    var z = alpha * (lastZ ?? data['z']) + (1 - alpha) * data['z'];
    print("X distance : $x");
    print("Y distance : $y");
    print("Z distance : $z");
  }
}
