import 'package:flutter/material.dart';
import 'package:najia/utils/constant.dart';
import 'package:najia/screens/hisnulmuslim/hisnulmuslim_card.dart';
import 'package:najia/screens/hisnulmuslim/hisnulmuslim_data.dart';

class HisnulMuslim extends StatelessWidget {
  const HisnulMuslim({Key? key}) : super(key: key);

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
            "HISNUL MUSLIM",
            style:
                TextStyle(fontSize: 12, letterSpacing: 8, color: Colors.black),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 243, 243, 243),
        body: ListView.builder(
            itemCount: hisnulMuslim.length,
            itemBuilder: (BuildContext context, int index) {
              final s = hisnulMuslim[index];
              return HisnulMuslimCard(
                context,
                s['title'].toString(),
                s['arabic'].toString(),
                s['english'].toString(),
                s['reference'].toString(),
              );
            }));
  }
}
