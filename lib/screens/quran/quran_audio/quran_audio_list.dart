import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:najia/utils/constant.dart';
import 'package:najia/animations/fade_animation.dart';
import 'package:najia/screens/quran/quran_audio/quran_audio_view.dart';
import 'package:najia/screens/quran/quran_audio/reciters_data.dart';

class QuranAudioList extends StatelessWidget {
  const QuranAudioList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<int> favourite = [
      9,
      22,
      62,
      66,
      67,
      73,
      76,
      86,
      94,
      140,
      142,
      162,
      165,
      168,
      181,
      191,
      194,
      196,
      198,
      201,
      210,
      214
    ];

    return Scaffold(
        appBar: AppBar(
          backgroundColor: NajiaColors.bgColor,
          centerTitle: true,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: const Text(
            "RECITER LIST",
            style:
                TextStyle(fontSize: 12, letterSpacing: 8, color: Colors.black),
          ),
        ),
        body: ListView.builder(
          itemCount: reciters.length,
          itemBuilder: (BuildContext context, int index) {
            final reciter = reciters[index];
            return FadeAnimation(
                delay: 200,
                child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      collapsedIconColor: NajiaColors.black,
                      iconColor: NajiaColors.black,
                      leading: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Icon(
                          LineIcons.headphones,
                          color: NajiaColors.black,
                        ),
                      ),
                      title: Row(
                        children: [
                          Text(
                            reciter['name'] + " ",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: NajiaColors.black,
                            ),
                          ),
                          if (favourite.contains(index))
                            SvgPicture.asset(
                              'assets/images/verified.svg',
                              height: 15,
                            )
                        ],
                      ),
                      children: <Widget>[
                        for (int i = 0; i < reciter['moshaf'].length; i++)
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QuranAudioView(
                                        reciter: index,
                                        reciterName: reciter['name'],
                                        rewaya: reciter['moshaf'][i]['name']
                                            .toString(),
                                        serverUrl: reciter['moshaf'][i]
                                            ['server'],
                                        availableSurah: reciter['moshaf'][i]
                                            ['surah_list'])),
                              );
                            },
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  reciter['moshaf'][i]['name'].toString(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 33, 33, 33)),
                                ),
                              ),
                            ),
                          ),
                      ],
                    )));
          },
        ));
  }
}
