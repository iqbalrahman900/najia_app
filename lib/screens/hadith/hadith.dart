import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:najia/utils/constant.dart';
import 'package:najia/animations/fade_animation.dart';
import 'package:najia/screens/hadith/hadith_chapter.dart';
import 'package:najia/screens/more/display_card.dart';

class Hadith extends StatelessWidget {
  const Hadith({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: NajiaColors.bgColor,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Text(
          "HADITH",
          style: TextStyle(fontSize: 12, letterSpacing: 8, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            FadeAnimation(
                delay: 200,
                child: displayCard(
                  context,
                  "Hadith Imam Abu Dawud",
                  const HadithChapter('Hadith Imam Abu Dawud', 'abudawud.json'),
                  const Icon(
                    LineIcons.quoteRight,
                    color: NajiaColors.black,
                  ),
                )),
            FadeAnimation(
                delay: 200,
                child: displayCard(
                  context,
                  "Hadith Imam Ahmad",
                  const HadithChapter('Hadith Imam Ahmad', 'ahmed.json'),
                  const Icon(
                    LineIcons.quoteRight,
                    color: NajiaColors.black,
                  ),
                )),
            FadeAnimation(
                delay: 200,
                child: displayCard(
                  context,
                  "Hadith Imam Bukhari",
                  const HadithChapter('Hadith Imam Bukhari', 'bukhari.json'),
                  const Icon(
                    LineIcons.quoteRight,
                    color: NajiaColors.black,
                  ),
                )),
            FadeAnimation(
                delay: 200,
                child: displayCard(
                  context,
                  "Hadith Ibnu Majah",
                  const HadithChapter('Hadith Ibnu Majah', 'ibnmajah.json'),
                  const Icon(
                    LineIcons.quoteRight,
                    color: NajiaColors.black,
                  ),
                )),
            FadeAnimation(
                delay: 200,
                child: displayCard(
                  context,
                  "Hadith Imam Malik",
                  const HadithChapter('Hadith Imam Malik', 'malik.json'),
                  const Icon(
                    LineIcons.quoteRight,
                    color: NajiaColors.black,
                  ),
                )),
            FadeAnimation(
                delay: 200,
                child: displayCard(
                  context,
                  "Hadith Imam An-Nasai",
                  const HadithChapter("Hadith Imam An-Nasai", 'nasai.json'),
                  const Icon(
                    LineIcons.quoteRight,
                    color: NajiaColors.black,
                  ),
                )),
            FadeAnimation(
                delay: 200,
                child: displayCard(
                  context,
                  "Hadith Imam Tarmizi",
                  const HadithChapter("Hadith Imam Tarmizi", 'tirmidhi.json'),
                  const Icon(
                    LineIcons.quoteRight,
                    color: NajiaColors.black,
                  ),
                )),
          ]),
        ),
      ),
    );
  }
}
