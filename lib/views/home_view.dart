import 'package:apinio_case_study/views/cv_view.dart';
import 'package:apinio_case_study/views/weather_forecasts.dart';
import 'package:flutter/material.dart';

import '../widgets/call_to_action.dart';
import '../widgets/navigation_drawer/navigation_drawer.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 1, 1, 51),
        title: const Text(
          'Choose',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 5, 35, 87),
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(width: 10),
              CallToAction(
                route: const WeatherForecastView('title'),
                title: 'Weather Forecast',
                image: const AssetImage("assets/home_weather.jpg"),
              ),
              const SizedBox(width: 15),
              CallToAction(
                route: const CVView(),
                title: 'CV Page',
                image: const AssetImage("assets/resume_background.jpg"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
