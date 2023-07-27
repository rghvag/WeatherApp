

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/weather_data_hourly.dart';
import '../utils/custom_color.dart';

class HourlyDataWidget extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;
  const HourlyDataWidget({super.key, required this.weatherDataHourly});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          alignment: Alignment.topCenter,
          child: Text(
            'Today',
            style: TextStyle(
              fontSize: 19,
            ),
          ),
        ),
        hourlyList(),
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      alignment: Alignment.topCenter,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index){
          return  GestureDetector(
            child: Container(
            decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0.5, 0),
                          blurRadius: 30,
                          spreadRadius: 1,
                          color: CustomColors.dividerLine.withAlpha(150))
                    ],
                    // gradient: cardIndex.value == index
                    //     ? const LinearGradient(colors: [
                    //         CustomColors.firstGradientColor,
                    //         CustomColors.secondGradientColor
                    //       ])
                    //     : null), 
                    //     child: HourlyDetails(
                    //       index: index,
                    //       cardIndex: cardIndex.toInt(),
                    //       temp: widget.weatherDataHourly.hourly[index].temp!,
                    //       timeStamp: widget.weatherDataHourly.hourly[index].dt!,
                    //       weatherIcon:
                    //           widget.weatherDataHourly.hourly[index].weather![0].icon!,
                        ),          
            ),

          );
        },
        itemCount: weatherDataHourly.hourly.length >12 ? 12 : weatherDataHourly.hourly.length,),
        
    );
  }
}


class HourlyDetails extends StatelessWidget {
  int temp;
  int index;
  int cardIndex;
  int timeStamp;
  String weatherIcon;

  HourlyDetails(
      {Key? key,
      required this.cardIndex,
      required this.index,
      required this.timeStamp,
      required this.temp,
      required this.weatherIcon})
      : super(key: key);
  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat('jm').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(getTime(timeStamp),
              style: TextStyle(
                color: cardIndex == index
                    ? Colors.white
                    : CustomColors.textColorBlack,
              )),
        ),
        Container(
            margin: const EdgeInsets.all(5),
            child: Image.asset(
              "assets/weather/$weatherIcon.png",
              height: 40,
              width: 40,
            )),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text("$temp°",
              style: TextStyle(
                color: cardIndex == index
                    ? Colors.white
                    : CustomColors.textColorBlack,
              )),
        )
      ],
    );
  }
}
