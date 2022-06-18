import 'package:flutter/material.dart';

class TemperatureItem extends StatelessWidget {
  final String hour;
  final int temp;
  final Icon icon;
  const TemperatureItem(
      {Key? key, required this.hour, required this.temp, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Text(
            hour.toString(),
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          icon,
          const SizedBox(height: 20),
          Text(
            "$temp\u00B0", // degree sign
            style: const TextStyle(
              fontSize: 40,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
