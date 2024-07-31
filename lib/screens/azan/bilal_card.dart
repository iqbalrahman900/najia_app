import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:najia/utils/constant.dart';
import 'package:najia/screens/azan/azan_player.dart';

bilalCard(context, title, url) {
  return InkWell(
    onTap: () => {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AzanPlayer(title: title, url: url)),
      )
    },
    child: Column(children: <Widget>[
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 5.0, left: 15),
                  child: Icon(
                    LineIcons.volumeUp,
                    color: NajiaColors.black,
                    size: 20,
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.90,
        child: const Divider(
          color: Colors.grey,
        ),
      ),
    ]),
  );
}
