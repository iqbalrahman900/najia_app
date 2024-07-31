import 'package:flutter/material.dart';
import 'package:najia/utils/constant.dart';

class HadithView extends StatelessWidget {
  final List<dynamic> hadiths;
  final String chapterTitle;

  const HadithView(this.hadiths, this.chapterTitle, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: NajiaColors.bgColor,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          chapterTitle.toUpperCase(),
          style: const TextStyle(
            fontSize: 12,
            letterSpacing: 8,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: hadiths.length,
        itemBuilder: (BuildContext context, int index) {
          final hadith = hadiths[index];
          final backgroundColor = index.isEven
              ? Colors.transparent
              : NajiaColors.bgColor; // Alternate colors

          return Container(
            color: backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    "${hadith['arabic']}\n\n",
                    style: const TextStyle(
                      fontFamily: 'naskh',
                      fontSize: 25,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  subtitle: Text(
                    hadith['english']['text'],
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
