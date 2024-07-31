import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:najia/animations/fade_animation.dart';
import 'package:najia/screens/quran/quran_choose/quran_data.dart';
import 'package:najia/utils/constant.dart';
import 'package:audioplayers/audioplayers.dart';

class ViewQuranVisual extends StatefulWidget {
  final String imagePath;
  final int surahNumber;
  final int ayatStart;
  final int ayatEnd;
  final String subtitle;

  ViewQuranVisual({
    required this.imagePath,
    required this.surahNumber,
    required this.ayatStart,
    required this.ayatEnd,
    required this.subtitle,
  });

  @override
  _ViewQuranVisualState createState() => _ViewQuranVisualState();
}

class _ViewQuranVisualState extends State<ViewQuranVisual> {
  late AudioPlayer audioPlayer;
  PlayerState? audioPlayerState;
  bool isPlaying = false;
  int indexPlaying = 9999;

  bool malay = true;
  bool english = true;
  bool chinese = true;
  bool tamil = true;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.PLAYING) {
        setState(() {
          isPlaying = true;
          audioPlayerState = state;
        });
      } else if (state == PlayerState.PAUSED) {
        setState(() {
          isPlaying = false;
          audioPlayerState = state;
        });
      } else if (state == PlayerState.STOPPED) {
        setState(() {
          isPlaying = false;
          audioPlayerState = state;
        });
      }
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void _play(verse) async {
    int result = await audioPlayer.play(
        'https://cdn.islamic.network/quran/audio/128/ar.alafasy/${verse}.mp3');
    if (result == 1) {
      setState(() {
        isPlaying = true;
        indexPlaying = verse;
      });
    }
  }

  void _pause() async {
    int result = await audioPlayer.pause();
    if (result == 1) {
      setState(() {
        isPlaying = false;
        indexPlaying = 9999;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredVerses = quranText
        .where((verse) =>
            verse['surah_number'] == widget.surahNumber &&
            verse['verse_number'] >= widget.ayatStart &&
            verse['verse_number'] <= widget.ayatEnd)
        .toList();
    final ayatTextStyle = TextStyle(fontSize: 16);

    print(widget.ayatStart);
    print(widget.ayatEnd);
    print(filteredVerses.length);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: NajiaColors.bgColor,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Text(
          "MOTIVATION",
          style: TextStyle(fontSize: 12, letterSpacing: 8, color: Colors.black),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredVerses.length,
        itemBuilder: (BuildContext context, int index) {
          final verse = filteredVerses[index];
          return FadeAnimation(
            delay: 200,
            child: Column(
              children: <Widget>[
                if (index == 0)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, right: 20.0, left: 20.0, bottom: 30),
                        child: SizedBox(
                          height: 100,
                          child: Stack(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.asset(
                                  widget.imagePath,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 100,
                                ),
                              ),
                              Positioned.fill(
                                child: Center(
                                  child: Text(
                                    widget.subtitle.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '${verse['content']}',
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            fontFamily: 'naskh',
                            fontSize: 35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '${verse['english']}',
                          style: ayatTextStyle,
                          key: Key('english_$index'),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '${verse['malay']}',
                          style: ayatTextStyle,
                          key: Key('malay_$index'),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 5.0), // Adjust vertical padding here
                        decoration: BoxDecoration(
                          color:
                              NajiaColors.black, // You can set any color here
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          'Quran ${widget.surahNumber}:${index + 1}',
                          style: ayatTextStyle.copyWith(color: Colors.white),
                          key: Key('ayat_$index'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: const Divider(
                    color: Color.fromARGB(51, 158, 158, 158),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
