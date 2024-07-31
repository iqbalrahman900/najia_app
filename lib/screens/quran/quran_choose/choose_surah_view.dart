import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:najia/animations/fade_animation.dart';
import 'package:najia/utils/constant.dart';
import 'quran_data.dart';

class ChooseSurahView extends StatefulWidget {
  final int surahNumber;
  final String surahName;
  final String english;
  final int totalVerse;
  final String place;
  final int startVerseNumber;

  ChooseSurahView(
      {required this.surahNumber,
      required this.surahName,
      required this.english,
      required this.totalVerse,
      required this.place,
      required this.startVerseNumber});

  @override
  _ChooseSurahViewState createState() => _ChooseSurahViewState();
}

Future<void> playAudio(String url) async {
  AudioPlayer player = AudioPlayer();
  int result = await player.play(url);
  if (result != 1) {
    throw Exception('Failed to play audio');
  }
}

class _ChooseSurahViewState extends State<ChooseSurahView> {
  late AudioPlayer audioPlayer;
  PlayerState? audioPlayerState;
  bool isPlaying = false;
  int indexPlaying = 9999;

  var userEmail = "N/A";
  var trimmedEmail = "N/A";

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

    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      userEmail = user?.email ?? 'No email';
    });
    String firstPartEmail = userEmail.split('@')[0];
    trimmedEmail = firstPartEmail.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
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
        .where((verse) => verse['surah_number'] == widget.surahNumber)
        .toList();
    final ayatTextStyle = TextStyle(fontSize: 16);

    final verseWidgets = Column(
      children: <Widget>[
        Column(
          children: [
            SizedBox(
              height: 110,
              child: SvgPicture.asset(
                'assets/images/title/surah_title_${widget.surahNumber}.svg',
                color: Colors.black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.english,
                  style: TextStyle(fontSize: 14),
                ),
                const Text(
                  " | ",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  widget.place,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${widget.totalVerse} ayat",
              style: const TextStyle(fontSize: 10),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.90,
              child: const Divider(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: NajiaColors.bgColor,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          widget.surahName.toUpperCase(),
          style: const TextStyle(
              fontSize: 12, letterSpacing: 8, color: Colors.black),
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
                if (index == 0) verseWidgets,
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
                              height: 2,
                              fontFamily: 'kitab_regular',
                              fontSize: 30),
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
                      Text(
                        'Ayat ${index + 1}',
                        style: ayatTextStyle,
                        key: Key('ayat_$index'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: NajiaColors.black,
                      ),
                      onPressed: () => addQuran(widget.surahNumber, index + 1),
                      child: const Text("SELECT"),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: const Divider(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  addQuran(surah, ayat) {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

    String surahNumber = surah.toString();
    String index = ayat.toString();

    // databaseReference.child("quran").push().set(data).then((_) {
    databaseReference
        .child("$trimmedEmail/quran/ayat")
        .set("$surahNumber:$index")
        .then((_) {})
        .catchError((error) {});
  }
}

void _showToast(BuildContext context, data) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(data + ' has been copied to clipboard!'),
      duration: const Duration(seconds: 2),
      backgroundColor: NajiaColors.black,
    ),
  );
}
