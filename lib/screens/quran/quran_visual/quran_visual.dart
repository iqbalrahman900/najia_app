import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:najia/animations/fade_animation.dart';
import 'package:najia/screens/quran/quran_visual/view_quran_visual.dart';
import 'package:najia/utils/constant.dart';

class QuranVisual extends StatefulWidget {
  final String? path;

  const QuranVisual({Key? key, this.path}) : super(key: key);

  @override
  _QuranVisualState createState() => _QuranVisualState();
}

class _QuranVisualState extends State<QuranVisual> {
  // Define an array of card data
  final List<Map<String, dynamic>> cardData = [
    {
      'imagePath': 'assets/images/qo10.png',
      'title': 'He who sustained my needs.',
      'subtitle': 'Ash-Shuara, Ayat 78-82',
      'surah': 26,
      'ayatStart': 78,
      'ayatEnd': 82,
    },
    {
      'imagePath': 'assets/images/qo2.png',
      'title': 'Do not despair!',
      'subtitle': 'Surah Az-Zumar, Ayat 53',
      'surah': 39,
      'ayatStart': 53,
      'ayatEnd': 53,
    },
    {
      'imagePath': 'assets/images/qo3.png',
      'title': "I'm not alone, Allah is always with me.",
      'subtitle': 'Surah Al-Hadid, Ayat 4',
      'surah': 57,
      'ayatStart': 4,
      'ayatEnd': 4,
    },
    {
      'imagePath': 'assets/images/qo4.png',
      'title': 'If the jail is better for me.',
      'subtitle': 'Surah Yusuf, Ayat 33',
      'surah': 12,
      'ayatStart': 33,
      'ayatEnd': 33,
    },
    {
      'imagePath': 'assets/images/qo5.png',
      'title': 'My heart is longing for Makkah.',
      'subtitle': 'Surah Al-Baqarah, Ayat 197',
      'surah': 2,
      'ayatStart': 197,
      'ayatEnd': 197,
    },
    {
      'imagePath': 'assets/images/qo6.png',
      'title': 'The forgiver of sin.',
      'subtitle': 'Surah An-Nahl, Ayat 119',
      'surah': 16,
      'ayatStart': 119,
      'ayatEnd': 119,
    },
    {
      'imagePath': 'assets/images/qo7.png',
      'title': 'The believing descendants.',
      'subtitle': 'Surah Ibrahim, Ayat 40',
      'surah': 14,
      'ayatStart': 40,
      'ayatEnd': 40,
    },
    {
      'imagePath': 'assets/images/qo8.png',
      'title': 'How do I serve my parent?',
      'subtitle': 'Surah Al-Isra, Ayat 23',
      'surah': 17,
      'ayatStart': 23,
      'ayatEnd': 23,
    },
    {
      'imagePath': 'assets/images/qo1.png',
      'title': 'Reminder for muslim men and women.',
      'subtitle': 'Surah An-Nur, Ayat 30-31',
      'surah': 24,
      'ayatStart': 30,
      'ayatEnd': 31,
    },
    {
      'imagePath': 'assets/images/qo9.png',
      'title': 'Tahajjud.',
      'subtitle': 'Surah Muzammil, Ayat 20',
      'surah': 73,
      'ayatStart': 20,
      'ayatEnd': 20,
    },

    // {
    //   'imagePath': 'assets/images/qo11.png',
    //   'title': 'Card 4 Title',
    //   'subtitle': 'Card 4 Subtitle',
    // },
    {
      'imagePath': 'assets/images/qo12.png',
      'title': 'Time, hours, minutes, routines.',
      'subtitle': 'Surah Al-Asr, Ayat 1-3',
      'surah': 103,
      'ayatStart': 1,
      'ayatEnd': 3,
    },
    // {
    //   'imagePath': 'assets/images/qo13.png',
    //   'title': 'Card 4 Title',
    //   'subtitle': 'Card 4 Subtitle',
    // },
    {
      'imagePath': 'assets/images/qo14.png',
      'title': 'O Allah protect me from hellfire.',
      'subtitle': 'Surah Al-Waqiah, Ayat 92-96',
      'surah': 56,
      'ayatStart': 92,
      'ayatEnd': 96,
    },
    {
      'imagePath': 'assets/images/qo15.png',
      'title': 'Ayat about repentance.',
      'subtitle': 'Surah At-Tahrim, Ayat 8',
      'surah': 66,
      'ayatStart': 8,
      'ayatEnd': 8,
    },
    {
      'imagePath': 'assets/images/qo16.png',
      'title': 'The path to success.',
      'subtitle': 'Surah Al-Muminun, Ayat 1-11',
      'surah': 23,
      'ayatStart': 1,
      'ayatEnd': 11,
    },
    {
      'imagePath': 'assets/images/qo17.png',
      'title': 'Ramadhan.',
      'subtitle': 'Surah Al-Baqarah, Ayat 183',
      'surah': 2,
      'ayatStart': 183,
      'ayatEnd': 183,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeAnimation(
        delay: 200,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: cardData.map((data) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewQuranVisual(
                            imagePath: data['imagePath'],
                            surahNumber: data['surah'],
                            ayatStart: data['ayatStart'],
                            ayatEnd: data['ayatEnd'],
                            subtitle: data['subtitle'],
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, right: 20.0, left: 20.0),
                      child: SizedBox(
                        height: 100,
                        child: Stack(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.asset(
                                data['imagePath'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 100,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    data['title'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  // Text(
                                  //   data['subtitle'],
                                  //   style: const TextStyle(
                                  //     color: Colors.white,
                                  //     fontSize: 14,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            // Add the new Row here
            Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
                right: 20.0,
                left: 20.0,
                bottom: 5.0,
              ),
              child: Container(
                height: 30,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "An artwork collaboration with ",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: NajiaColors.black,
                          fontFamily: 'barlow_regular',
                        ),
                      ),
                      const Text(
                        "qomikin ",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'barlow_regular',
                          color: NajiaColors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            'assets/images/verified.svg',
                            height: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
