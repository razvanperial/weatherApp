import 'package:flutter/material.dart';

import 'text_styles.dart';

//base skeleton on which the detailed informations cards are built
class GeneralCard extends StatelessWidget {
  final IconData icon;
  final String string1;
  final String string2;
  final String string3;
  const GeneralCard({
    Key? key,
    required this.icon,
    required this.string1,
    required this.string2,
    required this.string3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: 180,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 26, 63, 141).withOpacity(0.5),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 26, 63, 141).withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7, // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 5),
              Text(
                string1,
                style: style_detailed_card,
              ),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            string2,
            style: const TextStyle(
                fontSize: 27, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 28),
          Text(string3,
              style: const TextStyle(color: Colors.white, fontSize: 15)),
        ],
      ),
    );
  }
}
