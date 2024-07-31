import 'package:flutter/material.dart';
import 'package:najia/utils/constant.dart';
import 'package:najia/screens/more/more.dart';
import 'package:najia/screens/settings/setting_card.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

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
          "SETTINGS",
          style: TextStyle(fontSize: 12, letterSpacing: 8, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            const SizedBox(
              height: 15,
            ),
            SettingCard(
              context,
              "Azan Settings",
              More(),
              const Icon(
                Icons.settings,
                color: NajiaColors.black,
                size: 25,
              ),
            ),
            SettingCard(
              context,
              "Reciter Settings",
              More(),
              const Icon(
                Icons.settings,
                color: NajiaColors.black,
                size: 25,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
