import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
import 'package:weatherapp_starter_project/controllers/global_controller.dart';
import 'package:weatherapp_starter_project/widgets/current_weather_widget.dart';
import '../widgets/header_widget.dart';
import '../widgets/hourly_weather_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          (() => globalController.checkisloading().isTrue
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const headerWidget(),

                      //widget for current temperature {"current"}
                      CurrentWeatherWidget(
                        weatherDataCurrent:
                            globalController.getData().getcurrentWeather(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      HourlyDataWidget(
                        weatherDataHourly:
                            globalController.getData().getHourlyWeather(),
                      ),

                      Container(
                        
                      ),

                    ],
                  ),
                )),
        ),
      ),
    );
  }
}
