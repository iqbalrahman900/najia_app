import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:najia/animations/fade_animation.dart';
import 'package:najia/screens/quran/quran_text/surah_data.dart';
import 'package:najia/utils/constant.dart';
import 'package:najia/screens/quran/quran_choose/choose_surah_view.dart';

class ChooseSurah extends StatefulWidget {
  final String? path;

  const ChooseSurah({Key? key, this.path}) : super(key: key);

  @override
  _ChooseSurahState createState() => _ChooseSurahState();
}

class _ChooseSurahState extends State<ChooseSurah> {
  TextEditingController searchController = TextEditingController();
  List filteredSurah = surah;

  void filterChooseSurah(String query) {
    setState(() {
      filteredSurah = surah
          .where((s) =>
              s['name'].toLowerCase().contains(query.toLowerCase()) ||
              s['english'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Widget buildChooseSurahItem(BuildContext context, int index) {
    final s = filteredSurah[index];
    List<int> startVerse = [
      1
    ]; // first array or 1 for alfatihah, 7 for baqarah, 293 for ali imran and so on..
    int newTotal = 0;
    for (int i = 0; i < filteredSurah.length; i++) {
      newTotal = filteredSurah[i]["totalVerse"] + newTotal;
      startVerse.add(newTotal);
    }
    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChooseSurahView(
              surahNumber: s['id'],
              surahName: s['name'],
              english: s['english'],
              totalVerse: s['totalVerse'],
              place: s['place'],
              startVerseNumber: startVerse[index],
            ),
          ),
        )
      },
      child: Column(children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${s['id']}. ${s['name']}',
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
                        '${s['english']}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '${s['totalVerse']} ayat | ${s['place']}',
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
              )
            ],
          ),
        ),
      ]),
    );
  }

  @override
  void initState() {
    super.initState();
  }

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
        title: Text(
          "CHOOSE SURAH",
          style: const TextStyle(
              fontSize: 12, letterSpacing: 8, color: Colors.black),
        ),
      ),
      body: FadeAnimation(
        delay: 200,
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: filteredSurah.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildChooseSurahItem(context, index);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: const Divider(
                      color: Color.fromARGB(118, 158, 158, 158),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
