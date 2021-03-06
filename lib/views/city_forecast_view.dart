import 'package:apinio_case_study/classes/city_class.dart';
import 'package:apinio_case_study/widgets/info_card.dart';
import 'package:apinio_case_study/widgets/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'detailed_view.dart';

class CityForecastView extends StatefulWidget {
  final City city;
  AssetImage image = const AssetImage("assets/day_dry.jpeg");
  CityForecastView({Key? key, required this.city}) : super(key: key);

  @override
  State<CityForecastView> createState() => _CityForecastViewState();
}

class _CityForecastViewState extends State<CityForecastView> {
  Map? responseMap;
  Map? sunriseMap;
  Map? hourMap;
  late List forecast;
  late String temp;
  late int hour = 0;
  late int current_hour;
  late int sunrise_hour;
  late int sunset_hour;
  Icon icon = const Icon(CupertinoIcons.sun_max);

  @override
  void initState() {
    if (!mounted) return;
    super.initState();
    forecast = [];
    temp = "loading...";
    current_hour = 0;
    sunrise_hour = 0;
    sunset_hour = 0;
    getBackground();
  }

  Future<void> fetchForecast(double lat, double lon) async {
    if (!mounted) return;
    //call the api and save the json in a response map
    var uri = Uri.parse(
        'http://www.7timer.info/bin/api.pl?lon=$lon&lat=$lat&product=astro&output=json');
    http.Response response = await http.get(uri);
    var responseMap = jsonDecode(response.body);

    setState(
      () {
        if (!mounted) return;
        forecast = responseMap["dataseries"];
        temp = "${forecast[0]["temp2m"]}\u00B0 C"; // gets current temperature
      },
    );
  }

  Future<void> fetchSunrise(double lat, double lon) async {
    if (!mounted) return;
    //call the api and save the json in a response map

    var uri = Uri.parse(
        'https://api.sunrise-sunset.org/json?lat=$lat&lng=$lon&formatted=0');
    http.Response response = await http.get(uri);
    sunriseMap = jsonDecode(response.body);

    setState(() {
      if (!mounted) return;

      //calculate sunrise and sunset time for that specific location
      sunrise_hour = DateTime.parse(sunriseMap!["results"]["sunrise"]).hour;
      sunset_hour = DateTime.parse(sunriseMap!["results"]["sunset"]).hour;
    });
  }

  Future<void> fetchCurrentTime(String name, String continent) async {
    if (!mounted) return;
    //call the api and save the json in a response map

    var uri =
        Uri.parse('http://worldtimeapi.org/api/timezone/$continent/$name');
    http.Response response = await http.get(uri);
    hourMap = jsonDecode(response.body);

    setState(() {
      if (!mounted) return;

      //calculate current time for that specific location using API call
      hour = int.parse(hourMap!["datetime"].toString().substring(11, 13));
      current_hour = DateTime.parse(hourMap!["datetime"].toString()).hour;
    });
  }

  void getBackground() async {
    if (!mounted) return;
    setState(() {});
    List<Future> futures = [
      fetchForecast(widget.city.lat, widget.city.lon),
      fetchSunrise(widget.city.lat, widget.city.lon),
      fetchCurrentTime(widget.city.name, widget.city.continent),
    ];
    await Future.wait(futures);

    bool ok = true;

    if (sunrise_hour > sunset_hour) {
      ok = false;
    }

    if (ok == true) {
      //sunrise and sunset hours were returned in the same day
      if (current_hour > sunrise_hour && current_hour < sunset_hour) {
        // current hour is between sunrise and sunset hours, so it is day
        if (forecast[0]["prec_type"] == "none") {
          //set background image based on current conditions
          widget.image = const AssetImage("assets/day_dry.jpeg");
        } else {
          widget.image = const AssetImage("assets/day_rain.jpg");
        }
      } else {
        //current hour is outisde of sunrise and sunset hours, so it is night
        if (forecast[0]["prec_type"] == "none") {
          widget.image = const AssetImage("assets/night_dry.jpeg");
        } else {
          widget.image = const AssetImage("assets/night_rain.jpg");
        }
      }
    } else {
      //sunrise and sunset hours were returned in the consecutive days
      if (current_hour < sunrise_hour && current_hour > sunset_hour) {
        // current hour is between sunrise and sunset hours, so it is night
        if (forecast[0]["prec_type"] == "none") {
          //set background image based on current conditions
          widget.image = const AssetImage("assets/night_dry.jpeg");
        } else {
          widget.image = const AssetImage("assets/night_rain.jpg");
        }
      } else {
        //current hour is outisde of sunrise and sunset hours, so it is day
        if (forecast[0]["prec_type"] == "none") {
          widget.image = const AssetImage("assets/day_dry.jpeg");
        } else {
          widget.image = const AssetImage("assets/day_rain.jpg");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => DetailedView(
                      city: widget.city,
                      image: widget.image,
                    )),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: widget.image,
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 150),
              Text(
                widget.city.name,
                style: style_city_name,
              ),
              const SizedBox(height: 30),
              Text(
                temp,
                style: style_temperature,
              ),
              const SizedBox(height: 50),
              const Text('tap to see more information',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              temp != "loading..." // check for the response from the api and wait if necessary
                  ? InfoCard(
                      temperatures: forecast,
                      city: widget.city,
                      hour: hour,
                    )
                  : Container(
                      // default case
                      height: 200,
                      width: 350,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(221, 9, 31, 73)
                                .withOpacity(0.5),
                            blurRadius: 20.0,
                            spreadRadius: 3.0,
                          )
                        ],
                      ),
                    ),
            ],
          ),
        ));
  }
}
