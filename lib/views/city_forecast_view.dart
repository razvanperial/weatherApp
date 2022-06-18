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
  late List forecast;
  late String temp;
  late int hour;
  Icon icon = const Icon(CupertinoIcons.sun_max);

  @override
  void initState() {
    if (!mounted) return;
    super.initState();
    forecast = [];
    temp = "loading...";
    fetchForecast(widget.city.lat, widget.city.lon);
  }

  Future<void> fetchForecast(double lat, double lon) async {
    if (!mounted) return;
    //call the api and save the json in a response map
    var uri = Uri.parse(
        'http://www.7timer.info/bin/api.pl?lon=$lon&lat=$lat&product=astro&output=json');
    http.Response response = await http.get(uri);
    var responseMap = jsonDecode(response.body);
    setState(() {
      if (!mounted) return;

      //gets aproximate time at location in terms of longitude coordinate
      hour = DateTime.now().hour + ((lon - 13) / 15).round();
      hour = hour > 24 ? hour - 24 : hour; //adjust for next day switch
      forecast = responseMap["dataseries"];
      temp = "${forecast[0]["temp2m"]}\u00B0 C"; // gets current temperature
      if (hour <= 21 && hour >= 5) {
        //set background image based on current hour
        if (forecast[0]["prec_type"] == "none") {
          widget.image = const AssetImage("assets/day_dry.jpeg");
        } else {
          widget.image = const AssetImage("assets/day_rain.jpg");
        }
      } else {
        if (forecast[0]["prec_type"] == "none") {
          widget.image = const AssetImage("assets/night_dry.jpeg");
        } else {
          widget.image = const AssetImage("assets/night_rain.jpg");
        }
      }
    });
  }

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
      ),
    );
  }
}
