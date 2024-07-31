import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'package:najia/screens/qiblat/qiblat.dart';
import 'package:najia/screens/quran/quran.dart';
import 'package:najia/screens/prayers/prayers.dart';
import 'package:najia/utils/constant.dart';
import 'package:najia/screens/more/more.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NavigationBottomBar extends StatefulWidget {
  const NavigationBottomBar({super.key});

  @override
  _NavigationBottomBarState createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
              icon: const Icon(
                LineIcons.starAndCrescent,
              ),
              title: const Text("Prayer times"),
              selectedColor: NajiaColors.black),

          /// Quran
          SalomonBottomBarItem(
            icon: const Icon(
              LineIcons.book,
            ),
            title: const Text("Quran"),
            selectedColor: NajiaColors.black,
          ),

          /// Kiblat
          SalomonBottomBarItem(
            icon: const Icon(
              LineIcons.locationArrow,
            ),
            title: const Text("Kiblat"),
            selectedColor: NajiaColors.black,
          ),

          /// More
          SalomonBottomBarItem(
            icon: const Icon(
              LineIcons.horizontalSliders,
            ),
            title: const Text("More"),
            selectedColor: NajiaColors.black,
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          const Prayers(),
          const Quran(),
          // const MarketPlace(),
          QiblatPage(),
          const More(),
        ],
      ),
    );
  }
}
