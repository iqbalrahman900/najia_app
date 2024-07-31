import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:najia/animations/fade_animation.dart';
import 'package:najia/screens/quran/quran_text/surah_data.dart';
import 'package:najia/screens/quran/quran_text/surah_view.dart';

class SurahList extends StatefulWidget {
  final String? path;

  const SurahList({Key? key, this.path}) : super(key: key);

  @override
  _SurahListState createState() => _SurahListState();
}

class _SurahListState extends State<SurahList> {
  final TextEditingController searchController = TextEditingController();
  List filteredSurah = surah;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Widget buildSurahListItem(BuildContext context, int index) {
    final s = filteredSurah[index];
    final List<int> startVerse = [
      1
    ]; // first array or 1 for alfatihah, 7 for baqarah, 293 for ali imran and so on..

    for (int i = 0; i < filteredSurah.length; i++) {
      startVerse.add(filteredSurah[i]["totalVerse"] +
          (startVerse.isNotEmpty ? startVerse.last : 0));
    }

    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewAyat(
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
      child: Column(
        children: <Widget>[
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
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 15.0, left: 15),
                    //   child: Icon(
                    //     Icons.favorite_border,
                    //     size: 15,
                    //   ),
                    // ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${s['id']}. ${s['name']}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${s['english']}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '${s['totalVerse']} ayat | ${s['place']}',
                          style: TextStyle(
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeAnimation(
        delay: 200,
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: filteredSurah.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildSurahListItem(context, index);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: const Divider(
                      color: Color.fromARGB(24, 158, 158, 158),
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
