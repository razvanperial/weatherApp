import 'package:apinio_case_study/widgets/text_styles.dart';
import 'package:flutter/material.dart';

class CallToAction extends StatelessWidget {
  String title;
  Widget route;
  final AssetImage image;
  CallToAction(
      {Key? key, this.title = '', required this.route, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => route),
            );
          },
          child: Container(
            height: 280,
            width: 380,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: image,
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 63, 62, 62),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                title,
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.bold,
                  shadows: <Shadow>[
                    Shadow(
                      offset: const Offset(4.0, 4.0),
                      blurRadius: 8,
                      color:
                          const Color.fromARGB(255, 0, 0, 0).withOpacity(0.9),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
