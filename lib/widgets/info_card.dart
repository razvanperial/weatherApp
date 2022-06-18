import 'package:apinio_case_study/widgets/temperature_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../classes/city_class.dart';

class InfoCard extends StatelessWidget {
  final List temperatures;
  final City city;
  late int hour;
  InfoCard(
      {Key? key,
      required this.temperatures,
      required this.city,
      required this.hour})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Icon icon;
    return Container(
      height: 250,
      width: 350,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(221, 9, 31, 73).withOpacity(0.5),
            blurRadius: 20.0,
            spreadRadius: 3.0,
          )
        ],
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          hour = hour + 3 > 24 ? hour + 3 - 24 : hour + 3;
          // adjust for movement to the next day and move from 3 to 3 hours

          if (hour >= 21 || hour <= 4) {
            //day
            if (temperatures[index]["prec_type"] == "none") {
              icon = const Icon(CupertinoIcons.moon,
                  size: 50, color: Colors.white);
            } else {
              icon = const Icon(CupertinoIcons.cloud_moon_rain,
                  size: 50, color: Colors.white);
            }
          } else {
            //night
            if (temperatures[index]["prec_type"] == "none") {
              icon = const Icon(CupertinoIcons.sun_max,
                  size: 50, color: Colors.white);
            } else {
              icon = const Icon(CupertinoIcons.cloud_sun_rain,
                  size: 50, color: Colors.white);
            }
          }
          return TemperatureItem(
              hour: hour >= 10 ? hour.toString() : "0$hour",
              temp: temperatures[index]["temp2m"],
              icon: icon);
        },
      ),
    );
  }
}
