import 'package:flutter/material.dart';
import 'package:najia/utils/constant.dart';
import 'package:najia/screens/doa/doa_card.dart';
import 'package:najia/screens/doa/doa_data.dart';

class Doa extends StatelessWidget {
  const Doa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: NajiaColors.bgColor,
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0,
          title: const Text(
            "DOA",
            style:
                TextStyle(fontSize: 12, letterSpacing: 8, color: Colors.black),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 243, 243, 243),
        body: ListView.builder(
            itemCount: doaCollection.length,
            itemBuilder: (BuildContext context, int index) {
              final s = doaCollection[index];
              return doaCard(
                context,
                s['title'].toString(),
                s['arabic'].toString(),
                s['transliteration'].toString(),
                s['meaning'].toString(),
                s['source'].toString(),
              );
            }));
  }
}
