import 'dart:async';

import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:najia/utils/constant.dart';
import 'package:video_player/video_player.dart';

class LiveMeccaMadina extends StatefulWidget {
  const LiveMeccaMadina({Key? key}) : super(key: key);

  @override
  _LiveMeccaMadinaState createState() => _LiveMeccaMadinaState();
}

class _LiveMeccaMadinaState extends State<LiveMeccaMadina> {
  late VideoPlayerController _videoPlayerController1;
  late ChewieController _chewieController1;
  late VideoPlayerController _videoPlayerController2;
  late ChewieController _chewieController2;
  bool _isInitialized = false;

  late Timer _timer;
  late HijriCalendar _hijriCalendar;
  late DateTime _saudiArabiaTime;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayers();
    _hijriCalendar = HijriCalendar.now();
    _saudiArabiaTime = _getSaudiArabiaTime(DateTime.now());
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _saudiArabiaTime = _getSaudiArabiaTime(DateTime.now());
        _hijriCalendar = HijriCalendar.now();
      });
    });
  }

  void _initializeVideoPlayers() async {
    _videoPlayerController1 = VideoPlayerController.network(
      'https://win.holol.com/live/quran/playlist.m3u8',
    );
    _videoPlayerController2 = VideoPlayerController.network(
      'https://win.holol.com/live/sunnah/playlist.m3u8',
    );

    await Future.wait([
      _videoPlayerController1.initialize(),
      _videoPlayerController2.initialize(),
    ]);

    setState(() {
      _chewieController1 = ChewieController(
        videoPlayerController: _videoPlayerController1,
        autoPlay: true,
        looping: true,
        // You can customize the controls here if needed
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.red,
          handleColor: Colors.red,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.lightGreen,
        ),
        placeholder: Container(
          color: Colors.grey,
        ),
        autoInitialize: true,
      );

      _chewieController2 = ChewieController(
        videoPlayerController: _videoPlayerController2,
        autoPlay: true,
        looping: true,
        // You can customize the controls here if needed
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.red,
          handleColor: Colors.red,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.lightGreen,
        ),
        placeholder: Container(
          color: Colors.grey,
        ),
        autoInitialize: true,
      );

      _isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: NajiaColors.bgColor,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        title: const Text(
          "LIVE",
          style: TextStyle(fontSize: 12, letterSpacing: 8, color: Colors.black),
        ),
      ),
      body: _isInitialized
          ? ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Saudi Arabia Time: ${_formatTime(_saudiArabiaTime)}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Hijri Date: ${_hijriCalendar.toFormat("dd MMMM yyyy")}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'English Date: ${_saudiArabiaTime.day}-${_saudiArabiaTime.month}-${_saudiArabiaTime.year}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                _buildVideoPlayer(
                    _chewieController1, "Live stream from Masjidil Haram"),
                _buildVideoPlayer(
                    _chewieController2, "Live stream from Masjid An-Nabawi"),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _buildVideoPlayer(ChewieController? controller, String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: controller!.videoPlayerController.value.aspectRatio,
            child: Chewie(
              controller: controller,
            ),
          ),
          SizedBox(height: 8),
          Text(title),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController1.dispose();
    _chewieController1.dispose();
    _videoPlayerController2.dispose();
    _chewieController2.dispose();
    _timer.cancel();
  }

  DateTime _getSaudiArabiaTime(DateTime dateTime) {
    final saudiArabiaTimeZone = Duration(
        hours:
            3); // Saudi Arabia is 3 hours ahead of Coordinated Universal Time (UTC+3)
    return dateTime.toUtc().add(saudiArabiaTimeZone);
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour}:${dateTime.minute}:${dateTime.second}';
  }
}
