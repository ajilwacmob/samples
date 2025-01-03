import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samples/src/battery_percentage/service/battery_service.dart';
import 'package:samples/src/battery_percentage/service/device_position_service.dart';

class SensorHomeScreen extends StatefulWidget {
  const SensorHomeScreen({super.key});

  @override
  State<SensorHomeScreen> createState() => _SensorHomeScreenState();
}

class _SensorHomeScreenState extends State<SensorHomeScreen> {
  @override
  void initState() {
    super.initState();
    BatteryService.instance.startListeningToBattery();
    DevicePositionService.instance.startListeningToSensor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Sensors'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ValueListenableBuilder(
                valueListenable: BatteryService.instance.batteryNotifier,
                builder: (context, data, child) {
                  return Text(
                    data,
                    style: TextStyle(fontSize: 24.sp),
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
            20.verticalSpace,
            ValueListenableBuilder(
              valueListenable: DevicePositionService.instance.devicePosNotifier,
              builder: (context, data, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Device Position",
                          style: TextStyle(fontSize: 18.sp),
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Text(
                      "X : ${data['x'].toString()}",
                      style: TextStyle(fontSize: 24.sp),
                      textAlign: TextAlign.center,
                      maxLines: 4,
                    ),
                    Text(
                      "Y : ${data['y'].toString()}",
                      style: TextStyle(fontSize: 24.sp),
                      textAlign: TextAlign.center,
                      maxLines: 4,
                    ),
                    Text(
                      "Z : ${data['z'].toString()}",
                      style: TextStyle(fontSize: 24.sp),
                      textAlign: TextAlign.center,
                      maxLines: 4,
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
