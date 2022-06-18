// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

TextStyle style_city_name = TextStyle(
  fontSize: 50,
  color: Colors.white.withOpacity(0.9),
  fontWeight: FontWeight.bold,
  shadows: <Shadow>[
    Shadow(
      offset: const Offset(2.0, 2.0),
      blurRadius: 3,
      color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
    ),
  ],
);

TextStyle style_temperature = TextStyle(
  fontSize: 70,
  color: Colors.white.withOpacity(0.9),
  shadows: <Shadow>[
    Shadow(
      offset: const Offset(2.0, 2.0),
      blurRadius: 3,
      color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
    ),
  ],
);

TextStyle style_detailed_card = const TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  color: Color.fromARGB(255, 177, 174, 174),
);
