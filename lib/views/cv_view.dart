import 'package:apinio_case_study/widgets/cv_item.dart';
import 'package:apinio_case_study/widgets/navigation_drawer/navigation_drawer.dart';
import 'package:flutter/material.dart';

class CVView extends StatelessWidget {
  const CVView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawer(),
      appBar: AppBar(title: const Text("CV Page")),
      body: Center(
        child: Container(
          color: const Color.fromARGB(255, 104, 104, 104),
          child: Row(
            children: [
              const SizedBox(width: 7),
              SizedBox(
                height: 130,
                width: 90,
                child: Image.asset('assets/profile_pic.jpeg'),
              ),
              const SizedBox(width: 7),
              SizedBox(
                height: 110,
                child: Column(
                  children: [
                    const Text(
                      'PERIAL RAZVAN-ANDREI',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 26),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: const [
                        CVItem(
                            link: '"tel://+4917637567625',
                            name: '+49 176 37567625 |'),
                        CVItem(
                          link: '',
                          name: ' Dob: 09.09.2002 |',
                        ),
                        CVItem(
                          link: '',
                          name: ' razvanperial@gmail.com |',
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        CVItem(
                            link: 'https://www.linkedin.com/in/razvan-perial',
                            name:
                                'https://www.linkedin.com/in/razvan-perial |'),
                        CVItem(
                          link: '',
                          name: ' Nationality: Romanian |',
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        CVItem(
                            link: 'https://github.com/razvanperial',
                            name: ' https://github.com/razvanperial |'),
                        CVItem(
                            link:
                                'https://www.google.com/maps/place/College+III,+Campus+Ring+7,+28759+Bremen,+Germany/@53.1659073,8.6532104,17z/data=!3m1!4b1!4m5!3m4!1s0x47b12c9f010d1bb3:0x822ae4b631c02298!8m2!3d53.1659073!4d8.6553991',
                            name: ' Campus Ring, 28759, Germany'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
