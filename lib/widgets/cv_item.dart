import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CVItem extends StatelessWidget {
  final String link;
  final String name;

  const CVItem({Key? key, required this.link, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        () async {
          if (await canLaunchUrlString(link)) {
            await launchUrlString(link);
          } else {
            throw 'Could not launch $link';
          }
        };
      },
      child: Text(
        name,
        style: const TextStyle(color: Colors.white, fontSize: 10),
      ),
    );
  }
}
