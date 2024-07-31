import 'package:flutter/material.dart';
import 'package:najia/utils/constant.dart';
import 'package:najia/screens/azan/bilal_card.dart';

class BilalList extends StatelessWidget {
  const BilalList({Key? key}) : super(key: key);

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
            "AZAN",
            style:
                TextStyle(fontSize: 12, letterSpacing: 8, color: Colors.black),
          ),
        ),
        body: Column(
          children: [
            bilalCard(context, "Mishari Alafasy", "azan1.mp3"),
            bilalCard(context, "Ahmad Al-Nafees", "azan2.mp3"),
            bilalCard(context, "Mevlan Kurtishi", "azan3.mp3"),
            bilalCard(context, "Ahmad Al-Nufais", "azan4.mp3"),
            bilalCard(context, "Abdulrahman Al-Ausiy", "azan5.mp3"),
            bilalCard(context, "Abdulrahman Al-Hind", "azan6.mp3"),
          ],
        ));
  }
}
