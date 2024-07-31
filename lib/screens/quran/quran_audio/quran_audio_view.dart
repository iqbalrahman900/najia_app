import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:najia/utils/constant.dart';
import 'package:najia/animations/fade_animation.dart';
import 'package:najia/screens/quran/quran_audio/play_audio.dart';
import 'package:najia/screens/quran/quran_text/surah_data.dart';

class QuranAudioView extends StatefulWidget {
  final int reciter;
  final String reciterName;
  final String rewaya;
  final String availableSurah;
  final String serverUrl;

  QuranAudioView({
    required this.reciter,
    required this.reciterName,
    required this.rewaya,
    required this.availableSurah,
    required this.serverUrl,
  });

  @override
  _QuranAudioViewState createState() => _QuranAudioViewState();
}

class _QuranAudioViewState extends State<QuranAudioView> {
  @override
  Widget build(BuildContext context) {
    List<String> availableSurahList = (widget.availableSurah).split(',');

    return Scaffold(
        appBar: AppBar(
          backgroundColor: NajiaColors.bgColor,
          centerTitle: true,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            widget.reciterName.toUpperCase(),
            style:
                TextStyle(fontSize: 12, letterSpacing: 8, color: Colors.black),
          ),
        ),
        body: FadeAnimation(
            delay: 200,
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.builder(
                    itemCount: availableSurahList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final s = availableSurahList[index];
                      Map<String, dynamic> foundSurah = surah.firstWhere(
                          (surah) => surah['id'] == int.parse(s),
                          orElse: () => null);
                      return InkWell(
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlayAudio(
                                    surahNumber: int.parse(s),
                                    surahName: foundSurah['name'],
                                    rewaya: widget.rewaya,
                                    place: foundSurah['place'],
                                    english: foundSurah['english'],
                                    serverUrl: widget.serverUrl,
                                    reciterName: widget.reciterName),
                              ))
                        },
                        child: Column(children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 5.0),
                                      child: Icon(
                                        LineIcons.headphones,
                                        color: NajiaColors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '${foundSurah['name']}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          '${foundSurah['place']}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SvgPicture.asset(
                                  'assets/images/title/surah_title_${index + 1}.svg',
                                  height: 70,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: const Divider(
                              color: Color.fromARGB(255, 211, 211, 211),
                            ),
                          ),
                        ]),
                      );
                    }))));
  }
}
