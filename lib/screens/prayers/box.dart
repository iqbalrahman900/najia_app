import 'package:flutter/material.dart';
import 'package:najia/animations/fade_animation.dart';
import 'dart:ui' as ui;

renderBox() {
  return const FadeAnimation(
    delay: 200,
    child: Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Text(
              textDirection: ui.TextDirection.rtl,
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 2,
                fontFamily: 'naskh',
                fontSize: 28,
              ),
              "وَأَقِيمُواْ ٱلصَّلَوٰةَ وَءَاتُواْ ٱلزَّكَوٰةَ وَأَطِيعُواْ ٱلرَّسُولَ لَعَلَّكُمۡ تُرۡحَمُونَ",
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.0, right: 12.0),
            child: Text(
              textAlign: TextAlign.center,
              style: TextStyle(height: 1.5, fontSize: 14),
              "\nEstablish Prayer and pay Zakah and obey the Messenger so that mercy may be shown to you.\n\nAn-Nur: 56",
            ),
          ),
        ],
      ),
    ),
  );
}
