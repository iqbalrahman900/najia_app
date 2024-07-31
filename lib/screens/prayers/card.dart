import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:najia/utils/constant.dart';

Widget waktuCard(index, waktuType, waktuValue, waktuRemaining, incoming) {
  return GestureDetector(
    child: Padding(
      padding: const EdgeInsets.only(
        left: 5.0,
        right: 5.0,
      ),
      child: Column(
        children: [
          index != 0
              ? const Opacity(
                  opacity: 0.7,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(
                      height: 1,
                      color: Color.fromARGB(12, 0, 0, 0),
                    ),
                  ),
                )
              : const SizedBox(),
          Card(
              color: incoming ? NajiaColors.bgColor : Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: SizedBox(
                height: 60,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Image.asset(
                        "assets/images/waktu/${index + 1}.png",
                        fit: BoxFit.cover,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(waktuType, style: const TextStyle(fontSize: 18)),
                          Text(
                            waktuRemaining,
                            style: const TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(waktuValue,
                          style: const TextStyle(fontSize: 20)),
                    )
                  ],
                ),
              )),
        ],
      ),
    ),
  );
}

String convertTimeFormat(String timeString) {
  // Extract hour, minute, and second from the time string
  final hour = int.parse(timeString.substring(0, 2));
  final minute = int.parse(timeString.substring(3, 5));
  final second = int.parse(timeString.substring(6, 8));

  // Create a DateTime object with the extracted time
  final dateTime = DateTime(0, 0, 0, hour, minute, second);

  // Format the DateTime object into a readable format
  final formattedTime = DateFormat('h:mm a').format(dateTime);

  return formattedTime;
}
