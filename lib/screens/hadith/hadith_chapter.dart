import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:najia/utils/constant.dart';
import 'package:najia/screens/hadith/hadith_view.dart';

class HadithChapter extends StatefulWidget {
  final String title;
  final String fileName;

  const HadithChapter(this.title, this.fileName, {super.key});

  @override
  _HadithChapterState createState() => _HadithChapterState();
}

class _HadithChapterState extends State<HadithChapter> {
  List<dynamic> hadiths = [];
  List<dynamic> chapters = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/hadith/${widget.fileName}');
      final data = json.decode(jsonString);
      setState(() {
        chapters = data['chapters'];
        hadiths = data['hadiths'];
      });
    } catch (error) {
      if (kDebugMode) {
        print('Error loading JSON: $error');
      }
    }
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
          widget.title.toUpperCase(),
          style: const TextStyle(
            fontSize: 12,
            letterSpacing: 8,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: chapters.length,
        itemBuilder: (BuildContext context, int index) {
          final chapter = chapters[index];
          final chapterHadiths = hadiths.where((hadith) {
            return hadith['chapterId'] == chapter['id'];
          }).toList();

          return RenderChapter(
            context, chapter['english'],
            HadithView(chapterHadiths, chapter['english']),
            // You can provide an appropriate cardIcon here.
          );
        },
      ),
    );
  }
}

class RenderChapter extends StatelessWidget {
  final BuildContext context;
  final String title;
  final Widget page;

  const RenderChapter(this.context, this.title, this.page, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
        ),
        child: Card(
          elevation: 0,
          margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: SizedBox(
            width: double.infinity,
            child: ListTile(
              title: Text(title),
              trailing: const Icon(Icons.chevron_right_rounded),
            ),
          ),
        ),
      ),
    );
  }
}
