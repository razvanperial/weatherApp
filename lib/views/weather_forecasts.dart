import 'package:apinio_case_study/lists/city_list.dart';
import 'package:apinio_case_study/views/city_forecast_view.dart';
import 'package:apinio_case_study/views/current_city_view.dart';
import 'package:apinio_case_study/widgets/navigation_drawer/navigation_drawer.dart';
import 'package:flutter/material.dart';

class WeatherForecastView extends StatefulWidget {
  final String title;

  const WeatherForecastView(this.title);

  @override
  _WeatherForecastViewState createState() => _WeatherForecastViewState();
}

class _WeatherForecastViewState extends State<WeatherForecastView>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 1 + cityList.length);
  }

  @override
  void dispose() {
    if (!mounted) return;
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> cityViewList = [];

    cityViewList.add(CurrentCityView());

    //create the list of scrollable tabs
    for (var i = 0; i < cityList.length; i++) {
      cityViewList.add(CityForecastView(city: cityList[i]));
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const NavigationDrawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black.withOpacity(0.5),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(
            alignment: Alignment.center,
            child: TabPageSelector(controller: _tabController),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: cityViewList,
      ),
    );
  }
}
