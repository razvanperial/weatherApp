import 'package:apinio_case_study/classes/city_class.dart';
import 'package:apinio_case_study/widgets/general_card.dart';
import 'package:apinio_case_study/widgets/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailedView extends StatefulWidget {
  final City city;
  AssetImage image = const AssetImage("assets/day_dry.jpeg");
  DetailedView({Key? key, required this.city, required this.image})
      : super(key: key);

  @override
  State<DetailedView> createState() => _DetailedViewState();
}

class _DetailedViewState extends State<DetailedView> {
  Map? responseMap;
  late List forecast;
  late String temp;
  String cloudText = '';
  String visibilityText = '';
  String windText = '';
  String precipitationText = '';
  Icon icon = const Icon(CupertinoIcons.cloud_fill);

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
    var uri = Uri.parse(
        'http://www.7timer.info/bin/api.pl?lon=$lon&lat=$lat&product=astro&output=json');
    http.Response response = await http.get(uri);
    var responseMap = jsonDecode(response.body);
    setState(() {
      if (!mounted) return;
      forecast = responseMap["dataseries"];
      temp = "${forecast[0]["temp2m"]}\u00B0 C";
      //setting string variables for each instance of the class GeneralCard with suggestive texts
      cloudText =
          forecast[0]["cloudcover"] > 5 ? 'Mostly Cloudy' : 'Mostly Sunny';
      visibilityText = forecast[0]["seeing"] > 5
          ? 'Visibility might be affected'
          : 'Visibility is good';
      windText = forecast[0]["wind10m"]["speed"] < 5
          ? 'Light Breezes to nothing'
          : 'Today will be windy';
      precipitationText = forecast[0]["prec_type"] == "none"
          ? 'Today it will be dry'
          : 'Consider taking an umbrella';
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
      ),
      body: temp != 'loading...' // check the response from the api
          ? SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: widget.image,
                    fit: BoxFit.fill,
                  ),
                ),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 100),
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
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          GeneralCard(
                            icon: CupertinoIcons.cloud_rain_fill,
                            string1: 'Precipitation',
                            string2: forecast[0]["prec_type"].toString(),
                            string3: precipitationText,
                          ),
                          const SizedBox(width: 20),
                          GeneralCard(
                            icon: CupertinoIcons.cloud_fill,
                            string1: "Cloud coverage",
                            string2: "${forecast[0]["cloudcover"]} (out of 10)",
                            string3: cloudText,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          GeneralCard(
                            icon: CupertinoIcons.wind,
                            string1: 'Wind',
                            string2:
                                "${forecast[0]["wind10m"]["direction"]}, ${forecast[0]["wind10m"]["speed"]}km/h",
                            string3: windText,
                          ),
                          const SizedBox(width: 20),
                          GeneralCard(
                            icon: CupertinoIcons.eye,
                            string1: 'Visibility',
                            string2: "${forecast[0]["seeing"]} (out of 10)",
                            string3: visibilityText,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            )
          : const Center(
              // default case
              child: Text(
                'Loading Info...',
                style: TextStyle(fontSize: 30),
              ),
            ),
    );
  }
}
