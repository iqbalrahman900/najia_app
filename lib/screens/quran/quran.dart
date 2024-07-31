import 'package:flutter/material.dart';
import 'package:najia/screens/quran/quran_text/surah_list.dart';
import 'package:najia/utils/constant.dart';

class Quran extends StatefulWidget {
  final String? path;

  const Quran({Key? key, this.path}) : super(key: key);

  @override
  _QuranState createState() => _QuranState();
}

class _QuranState extends State<Quran> {
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // bottom: const TabBar(
          //   indicatorColor: NajiaColors.black,
          //   indicatorSize: TabBarIndicatorSize.label,
          //   tabs: [
          //     Padding(
          //       padding: EdgeInsets.all(12.0),
          //       child: Text(
          //         "Quran",
          //         style: TextStyle(color: Colors.black),
          //       ),
          //     ),
          //     Padding(
          //       padding: EdgeInsets.all(12.0),
          //       child: Text(
          //         "Motivation",
          //         style: TextStyle(color: Colors.black),
          //       ),
          //     ),
          //   ],
          // ),
          backgroundColor: NajiaColors.bgColor,
          centerTitle: true,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: const Text(
            "QURAN",
            style:
                TextStyle(fontSize: 12, letterSpacing: 8, color: Colors.black),
          ),
        ),
        body: const TabBarView(
          children: [
            SurahList(),
            // QuranVisual(),
          ],
        ),
      ),
    );
  }
}
