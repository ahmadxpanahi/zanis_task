import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zanis_task/view_models/weather_view_model.dart';

// Controller as a Mixin make code cleaner.
mixin WeatherController {
  static const EventChannel _eventChannel = EventChannel('ZANIS-CHANNEL');

  // using Rx type because i used GetX State Management for this task
  // all of the data that used Rx will change without setState.
  RxList<WeatherViewModel> weatherData = <WeatherViewModel>[].obs;

  void startDataConnection() {
    // this will call the stream channel from IOS
    _eventChannel.receiveBroadcastStream().listen((event) {
      if (event == "Stopped Sending Data") {
        debugPrint(event);
      } else {
        Map<String, dynamic> parsedMap = jsonDecode(event);
        debugPrint(parsedMap.toString());
        weatherData.add(WeatherViewModel(
          temperature: parsedMap["temperature"].toString(),
          humidity: parsedMap["humidity"].toString(),
        ));
      }
    });
  }

  // this will stop connection in IOS channel
  void stopDataConnection() {
    _eventChannel.receiveBroadcastStream().listen((_) {}).cancel();
  }
}
