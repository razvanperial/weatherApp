import 'package:flutter/material.dart';

class NavbarItem extends StatelessWidget {
  final Widget route;
  final String name;
  const NavbarItem({Key? key, required this.route, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => route),
        );
      },
      child: Text(
        name,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 30,
        ),
      ),
    );
  }
}
