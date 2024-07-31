import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:najia/screens/developer/developer.dart';
import 'package:najia/screens/live/live.dart';
import 'package:najia/utils/constant.dart';
import 'package:najia/animations/fade_animation.dart';
import 'package:najia/screens/asmaulhusna/asmaulhusna.dart';
import 'package:najia/screens/doa/doa.dart';
import 'package:najia/screens/hadith/hadith.dart';
import 'package:najia/screens/more/display_card.dart';
import 'package:najia/screens/najiatv/najiatv.dart';
import 'package:najia/screens/najiatv/najiatv_login.dart';
import 'package:najia/screens/quran/quran_audio/quran_audio_list.dart';
import 'package:najia/screens/tasbih/tasbih.dart';
import 'package:najia/screens/zone/zone.dart';

class More extends StatelessWidget {
  const More({Key? key}) : super(key: key);

  Widget buildCard(
      BuildContext context, String title, Widget content, Widget icon) {
    return FadeAnimation(
      delay: 200,
      child: displayCard(
        context,
        title,
        content,
        icon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final cardData = [
      {
        "title": "Quran Recitations",
        "content": const QuranAudioList(),
        "icon": const Icon(
          LineIcons.headphones,
          color: NajiaColors.black,
        ),
      },
      {
        "title": "Hadith Collections",
        "content": const Hadith(),
        "icon": const Icon(
          LineIcons.quoteRight,
          color: NajiaColors.black,
        ),
      },
      {
        "title": "Daily Doa",
        "content": const Doa(),
        "icon": SvgPicture.asset(
          'assets/icons/quran.svg',
          height: 20,
        ),
      },
      {
        "title": "Asmaul Husna",
        "content": const AsmaulHusna(),
        "icon": SvgPicture.asset(
          'assets/icons/asmaulhusna.svg',
          height: 23,
        ),
      },
      {
        "title": "Tasbih Digital",
        "content": const Tasbih(),
        "icon": const Icon(
          LineIcons.ioxhost,
          color: NajiaColors.black,
        ),
      },
      // {
      //   "title": "Nearby Mosque",
      //   "content":  NearestMosque(),
      //   "icon": SvgPicture.asset(
      //     'assets/icons/dome.svg',
      //     height: 20,
      //   ),
      // },
      {
        "title": "Live Mecca & Madinah",
        "content": const LiveMeccaMadina(),
        "icon": SvgPicture.asset(
          'assets/icons/dome.svg',
          height: 23,
        ),
      },
      {
        "title": "Select Zone",
        "content": Zone(),
        "icon": const Icon(
          LineIcons.locationArrow,
          color: NajiaColors.black,
        ),
      },
      {
        "title": "Najia TV",
        "content": user != null ? NajiaTV() : NajiaTVLogin(),
        "icon": const Icon(
          LineIcons.television,
          color: NajiaColors.black,
        ),
      },
      {
        "title": "Contact Developer",
        "content": Developer(),
        "icon": const Icon(
          LineIcons.code,
          color: NajiaColors.black,
        ),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: NajiaColors.bgColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          "MORE",
          style: TextStyle(fontSize: 12, letterSpacing: 8, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              for (final data in cardData)
                buildCard(
                  context,
                  data["title"] as String,
                  data["content"] as Widget,
                  data["icon"] as Widget,
                ),
              const SizedBox(height: 100),
              Container(
                height: 100,
                margin: const EdgeInsets.only(bottom: 30),
                child: const Column(
                  children: [
                    Image(
                      height: 30,
                      image: AssetImage('assets/images/najia_logo.png'),
                    ),
                    SizedBox(height: 15),
                    Text("Made with ♡ by Najia App Studio"),
                    SizedBox(height: 3),
                    Text(
                      "Copyright 2024",
                      style: TextStyle(fontSize: 10),
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
