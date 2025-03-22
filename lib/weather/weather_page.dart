import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zanis_task/weather/weather_controller.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> with WeatherController {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            Expanded(
              // using Obx widget for GetX state management (all of the widget inside Obx will update)
              child: Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text("Temperature Data"),
                            ...weatherData.map(
                              (e) => Text(e.temperature ?? "--"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text("Humidity Data"),
                            ...weatherData.map(
                              (e) => Text(e.humidity ?? "--"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        startDataConnection();
                      },
                      child: Text("Start"),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        stopDataConnection();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Data Communication Stopped!"),
                          ),
                        );
                      },
                      child: Text("Stop"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
