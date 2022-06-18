import 'package:apinio_case_study/views/cv_view.dart';
import 'package:apinio_case_study/views/home_view.dart';
import 'package:apinio_case_study/views/weather_forecasts.dart';
import 'package:apinio_case_study/widgets/navigation_drawer/navbar_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 16),
        ],
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 40),
          GestureDetector(
              onTap: (() {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomeView()),
                );
              }),
              child: const Icon(CupertinoIcons.home,
                  color: Colors.white, size: 35)),
          const SizedBox(height: 50),
          const NavbarItem(
              route: WeatherForecastView('title'), name: 'Weather Forecasts'),
          const SizedBox(height: 50),
          const NavbarItem(route: CVView(), name: 'CV Page'),
        ],
      ),
    );
  }
}
