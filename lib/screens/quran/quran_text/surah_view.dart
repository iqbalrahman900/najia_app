import 'package:audio_session/audio_session.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart' as justAudio;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:najia/animations/fade_animation.dart';
import 'package:najia/screens/quran/quran_audio/common.dart';
import 'package:najia/utils/constant.dart';
import 'quran_data.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/foundation.dart';

class ViewAyat extends StatefulWidget {
  final int surahNumber;
  final String surahName;
  final String english;
  final int totalVerse;
  final String place;
  final int startVerseNumber;

  ViewAyat(
      {required this.surahNumber,
      required this.surahName,
      required this.english,
      required this.totalVerse,
      required this.place,
      required this.startVerseNumber});

  @override
  _ViewAyatState createState() => _ViewAyatState();
}

Future<void> playAudio(String url) async {
  AudioPlayer player = AudioPlayer();
  int result = await player.play(url);
  if (result != 1) {
    throw Exception('Failed to play audio');
  }
}

class _ViewAyatState extends State<ViewAyat> with WidgetsBindingObserver {
  late AudioPlayer audioPlayer;
  final _player = justAudio.AudioPlayer();
  PlayerState? audioPlayerState;
  bool isPlaying = false;
  int indexPlaying = 9999;
  var bottomPlayer = true;

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
    ambiguate(WidgetsBinding.instance)!.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    _player.playbackEventStream
        .listen((event) {}, onError: (Object e, StackTrace stackTrace) {});
    try {
      print(
          'https://server16.mp3quran.net/nufais/Rewayat-Hafs-A-n-Assem/${widget.surahNumber.toString().padLeft(3, '0')}.mp3');
      await _player.setAudioSource(justAudio.AudioSource.uri(Uri.parse(
          'https://server16.mp3quran.net/nufais/Rewayat-Hafs-A-n-Assem/${widget.surahNumber.toString().padLeft(3, '0')}.mp3')));
    } catch (e) {
      if (kDebugMode) {
        print("Error loading audio source: $e");
      }
    }
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));
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
                  style: const TextStyle(fontSize: 14),
                ),
                const Text(
                  " ・  ",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  widget.place,
                  style: const TextStyle(fontSize: 14),
                ),
                const Text(
                  " ・  ",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "${widget.totalVerse} ayat",
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.90,
              child: const Divider(
                color: Color.fromARGB(51, 158, 158, 158),
              ),
            ),
            const SizedBox(
              height: 30,
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
        // actions: [
        //   PopupMenuButton<List<String>>(
        //     onSelected: (selectedTranslations) {
        //       // Handle the selected translations
        //       print('Selected translations: $selectedTranslations');
        //       // Add your translation logic here
        //     },
        //     itemBuilder: (BuildContext context) {
        //       List<String> selectedTranslations = [];

        //       return <PopupMenuEntry<List<String>>>[
        //         PopupMenuItem<List<String>>(
        //           value: selectedTranslations,
        //           child: SizedBox(
        //             width: 150, // Set the width as needed
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 CheckboxListTile(
        //                   title: const Text('Malay'),
        //                   value: malay,
        //                   onChanged: (value) {
        //                     // Update the boolean value when the checkbox is changed
        //                     setState(() {
        //                       malay = value!;
        //                     });
        //                   },
        //                 ),
        //                 CheckboxListTile(
        //                   title: const Text('English'),
        //                   value: english,
        //                   onChanged: (value) {
        //                     setState(() {
        //                       english = value!;
        //                     });
        //                   },
        //                 ),
        //                 CheckboxListTile(
        //                   title: const Text('Chinese'),
        //                   value: chinese,
        //                   onChanged: (value) {
        //                     setState(() {
        //                       chinese = value!;
        //                     });
        //                   },
        //                 ),
        //                 CheckboxListTile(
        //                   title: const Text('Tamil'),
        //                   value: tamil,
        //                   onChanged: (value) {
        //                     setState(() {
        //                       tamil = value!;
        //                     });
        //                   },
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ];
        //     },
        //     child: Padding(
        //       padding: const EdgeInsets.only(right: 20.0),
        //       child: Icon(
        //         Icons.translate,
        //         size: 20.0,
        //         color: Color.fromARGB(
        //             145, 0, 0, 0), // Customize the color as needed
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: Stack(
        children: [
          ListView.builder(
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
                          Expanded(
                            child: Text(
                              '${verse['chinese']}',
                              style: ayatTextStyle,
                              key: Key('chinese_$index'),
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
                              '${verse['tamil']}',
                              style: ayatTextStyle,
                              key: Key('tamil_$index'),
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
                              '${verse['japanese']}',
                              style: ayatTextStyle,
                              key: Key('japanese_$index'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 5.0), // Adjust vertical padding here
                            decoration: BoxDecoration(
                              color: NajiaColors
                                  .black, // You can set any color here
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text(
                              'Quran ${widget.surahNumber}:${index + 1}',
                              style:
                                  ayatTextStyle.copyWith(color: Colors.white),
                              key: Key('ayat_$index'),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: GestureDetector(
                                  onTap: () async => {
                                    await Clipboard.setData(
                                      ClipboardData(
                                        text:
                                            "${verse['content']}\n\n${verse['english']}\n\nQuran ${widget.surahNumber}:${index + 1}\n\nShared with Najia App",
                                      ),
                                    ),
                                    _showToast(context,
                                        "(Quran ${widget.surahNumber}:${index + 1})"),
                                  },
                                  child: const Icon(Icons.copy,
                                      color: NajiaColors.black),
                                ),
                              ),

                              // Padding(
                              //   padding: const EdgeInsets.only(right: 10.0),
                              //   child: GestureDetector(
                              //     onTap: () async {
                              //       setState(() {
                              //         _isBookmarked =
                              //             !_isBookmarked; // Toggle bookmark status
                              //       });
                              //       if (_isBookmarked) {
                              //         // Remove bookmark logic
                              //         _deleteBookmark(context, widget.surahNumber,
                              //             (index + 1).toString());
                              //       } else {
                              //         // Add bookmark logic
                              //         await _addBookmark(
                              //             context,
                              //             widget.surahNumber.toString(),
                              //             (index + 1).toString());
                              //       }
                              //     },
                              //     child: _isBookmarked
                              //         ? const Icon(
                              //             Icons.bookmark,
                              //             color: Colors.amber,
                              //           )
                              //         : const Icon(
                              //             Icons.bookmark_border_rounded,
                              //             color: Colors.amber,
                              //           ),
                              //   ),
                              // ),
                              // Text(_bookmarks.toString()),

                              // Padding(
                              //   padding: const EdgeInsets.only(right: 10.0),
                              //   child: GestureDetector(
                              //       onTap: () => {
                              //             widget.surahNumber == 1
                              //                 ? indexPlaying ==
                              //                         verse['verse_number']
                              //                     ? _pause()
                              //                     : _play(
                              //                         widget.startVerseNumber +
                              //                             index)
                              //                 : indexPlaying -
                              //                             widget
                              //                                 .startVerseNumber ==
                              //                         verse['verse_number']
                              //                     ? _pause()
                              //                     : _play(
                              //                         widget.startVerseNumber +
                              //                             index),
                              //           },
                              //       child: widget.surahNumber == 1
                              //           ? indexPlaying == verse['verse_number']
                              //               ? const Icon(
                              //                   Icons.pause_circle_filled_sharp,
                              //                   color: NajiaColors.black)
                              //               : const Icon(
                              //                   Icons
                              //                       .play_circle_outline_outlined,
                              //                   color: NajiaColors.black)
                              //           : indexPlaying -
                              //                       widget.startVerseNumber ==
                              //                   verse['verse_number'] - 1
                              //               ? const Icon(
                              //                   Icons.pause_circle_filled_sharp,
                              //                   color: NajiaColors.black)
                              //               : const Icon(
                              //                   Icons
                              //                       .play_circle_outline_outlined,
                              //                   color: NajiaColors.black)),
                              // ),
                            ],
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
          Positioned(
            left: 25,
            bottom: 40,
            child: bottomPlayer
                ? const SizedBox()
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: NajiaColors.black,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.play_arrow_rounded,
                          color: Colors.white),
                      onPressed: () {
                        setState(() {
                          bottomPlayer = true;
                          print(bottomPlayer);
                        });
                      },
                    ),
                  ),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 30,
              child: bottomPlayer
                  ? Container(
                      height: 120,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: NajiaColors.black,
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 0.0),
                              child: ControlButtons(_player),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 18.0),
                                  child: Text(
                                    widget.surahName,
                                    style: const TextStyle(
                                        color: NajiaColors.bgColor,
                                        fontSize: 16),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 18.0),
                                  child: Text(
                                    "Syeikh Ahmad Al-Nufays",
                                    style: TextStyle(
                                        color: NajiaColors.bgColor,
                                        fontSize: 10),
                                  ),
                                ),
                                StreamBuilder<PositionData>(
                                  stream: _positionDataStream,
                                  builder: (context, snapshot) {
                                    final positionData = snapshot.data;
                                    return SeekBar(
                                      duration: positionData?.duration ??
                                          Duration.zero,
                                      position: positionData?.position ??
                                          Duration.zero,
                                      bufferedPosition:
                                          positionData?.bufferedPosition ??
                                              Duration.zero,
                                      onChangeEnd: _player.seek,
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 0.0, right: 16.0),
                              child: IconButton(
                                icon: const Icon(Icons.close),
                                color: NajiaColors.bgColor,
                                iconSize: 30.0,
                                onPressed: () {
                                  setState(() {
                                    bottomPlayer = false;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox()),
        ],
      ),
    );
  }
}

class ControlButtons extends StatelessWidget {
  final justAudio.AudioPlayer player;

  const ControlButtons(this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<justAudio.PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == justAudio.ProcessingState.loading ||
                processingState == justAudio.ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: const CircularProgressIndicator(
                  color: NajiaColors.bgColor,
                ),
              );
            } else if (playing != true) {
              return IconButton(
                icon: const Icon(
                  Icons.play_circle_fill_rounded,
                  color: NajiaColors.bgColor,
                ),
                iconSize: 64.0,
                onPressed: player.play,
              );
            } else if (processingState != justAudio.ProcessingState.completed) {
              return IconButton(
                icon: const Icon(Icons.pause_circle_filled_rounded),
                color: NajiaColors.bgColor,
                iconSize: 64.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.replay_circle_filled_rounded),
                color: NajiaColors.bgColor,
                iconSize: 64.0,
                onPressed: () => player.seek(Duration.zero),
              );
            }
          },
        ),
      ],
    );
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
