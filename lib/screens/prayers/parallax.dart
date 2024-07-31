import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:najia/utils/constant.dart';

renderParallax(
    context,
    acceleration,
    nextPrayerTimeIndex,
    remainingTimes,
    planetMotionSensitivity,
    textMotionSensitivity,
    bgMotionSensitivity,
    zone,
    imsak,
    fajr,
    syuruk,
    dhuhr,
    asr,
    maghrib,
    isha) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.width,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Stack(
        children: <Widget>[
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            top: (acceleration.z ?? 0) * bgMotionSensitivity,
            bottom: (acceleration.z ?? 0) * -bgMotionSensitivity,
            right: (acceleration.x ?? 0) * -bgMotionSensitivity,
            left: (acceleration.x ?? 0) * bgMotionSensitivity,
            child: Align(
              child: Transform.scale(
                scale: 1.1,
                child: Image.asset(
                  "assets/images/lbg.png",
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            top: (acceleration.z ?? 0) * bgMotionSensitivity,
            bottom: (acceleration.z ?? 0) * -bgMotionSensitivity,
            right: (acceleration.x ?? 0) * -bgMotionSensitivity,
            left: (acceleration.x ?? 0) * bgMotionSensitivity,
            child: Align(
              child: Transform.scale(
                scale: 1.5,
                child: Opacity(
                  opacity: 1,
                  child: Lottie.asset(
                    'assets/images/particles.json',
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            top: ((acceleration.z ?? 0) * textMotionSensitivity) - 50,
            bottom: ((acceleration.z ?? 0) * -textMotionSensitivity) + 50,
            right: (acceleration.x ?? 0) * -textMotionSensitivity,
            left: (acceleration.x ?? 0) * textMotionSensitivity,
            child: Align(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                renderPrayerTimes(nextPrayerTimeIndex, remainingTimes, imsak,
                    fajr, syuruk, dhuhr, asr, maghrib, isha),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  color: NajiaColors.bgColor,
                  child: const SizedBox(
                    height: 1,
                    width: 150,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          zone,
                          overflow: TextOverflow.visible,
                          style: const TextStyle(
                            color: NajiaColors.bgColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            top: (acceleration.z ?? 0) * planetMotionSensitivity,
            bottom: (acceleration.z ?? 0) * -planetMotionSensitivity,
            right: (acceleration.x ?? 0) * -planetMotionSensitivity,
            left: (acceleration.x ?? 0) * planetMotionSensitivity,
            child: Align(
              child: Transform.scale(
                scale: 1.7,
                child: Image.asset(
                  "assets/images/lfg.png",
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

renderPrayerTimes(
    int index, remainingTimes, imsak, fajr, syuruk, dhuhr, asr, maghrib, isha) {
  String prayerName;
  String prayerValue;
  String remainingTime;

  switch (index) {
    case 0:
      prayerName = "Imsak";
      prayerValue = imsak;
      remainingTime = remainingTimes[0];
      break;
    case 1:
      prayerName = "Subuh";
      prayerValue = fajr;
      remainingTime = remainingTimes[1];
      break;
    case 2:
      prayerName = "Syuruk";
      prayerValue = syuruk;
      remainingTime = remainingTimes[2];
      break;
    case 3:
      prayerName = "Zohor";
      prayerValue = dhuhr;
      remainingTime = remainingTimes[3];
      break;
    case 4:
      prayerName = "Asar";
      prayerValue = asr;
      remainingTime = remainingTimes[4];
      break;
    case 5:
      prayerName = "Maghrib";
      prayerValue = maghrib;
      remainingTime = remainingTimes[5];
      break;
    case 6:
      prayerName = "Isha";
      prayerValue = isha;
      remainingTime = remainingTimes[6];
      break;
    default:
      prayerName = "N/A";
      prayerValue = "N/A";
      remainingTime = "N/A";
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        prayerName,
        style: const TextStyle(
          color: NajiaColors.bgColor,
          fontSize: 20,
        ),
      ),
      Text(
        prayerValue,
        style: const TextStyle(
          color: NajiaColors.bgColor,
          fontSize: 50,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        remainingTime,
        style: const TextStyle(
          color: NajiaColors.bgColor,
          fontSize: 15,
        ),
      ),
    ],
  );
}
