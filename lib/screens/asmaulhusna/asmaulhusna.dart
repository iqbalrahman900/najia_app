import 'package:flutter/material.dart';
import 'package:najia/utils/constant.dart';
import 'package:najia/screens/asmaulhusna/asmaulhusna_card.dart';
import 'package:najia/screens/asmaulhusna/asmaulhusna_data.dart';

class AsmaulHusna extends StatelessWidget {
  const AsmaulHusna({Key? key}) : super(key: key);

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
            "ASMAUL HUSNA",
            style:
                TextStyle(fontSize: 12, letterSpacing: 8, color: Colors.black),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 243, 243, 243),
        body: ListView.builder(
            itemCount: asmaulHusna.length,
            itemBuilder: (BuildContext context, int index) {
              final s = asmaulHusna[index];
              return asmaulHusnaCard(
                context,
                s['name'].toString(),
                s['transliteration'].toString(),
                s['en']['meaning'].toString(),
              );
            }));
  }
}
