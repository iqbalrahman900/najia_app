import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:najia/animations/fade_animation.dart';
import 'package:najia/utils/constant.dart';
import 'package:smooth_compass/utils/src/compass_ui.dart';

class QiblatPage extends StatefulWidget {
  const QiblatPage({Key? key}) : super(key: key);

  @override
  _QiblatPageState createState() => _QiblatPageState();
}

class _QiblatPageState extends State<QiblatPage>
    with AutomaticKeepAliveClientMixin {
  // Add a flag to keep track of the page's state
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Ensure this line is included.

    return Scaffold(
      appBar: AppBar(
        backgroundColor: NajiaColors.bgColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          "QIBLAT",
          style: TextStyle(fontSize: 12, letterSpacing: 8, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: NajiaColors.bgColor,
            border: Border.all(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: CompassWidget(),
          ),
        ),
      ),
    );
  }

  CompassWidget() {
    return SmoothCompass(
      isQiblahCompass: true,
      compassBuilder: (context, snapshot, child) {
        return FadeAnimation(
            delay: 200,
            child: AnimatedRotation(
              duration: const Duration(milliseconds: 800),
              turns: snapshot?.data?.turns ?? 0,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: SvgPicture.asset('assets/images/compass1.svg')),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: AnimatedRotation(
                        duration: const Duration(milliseconds: 500),
                        turns: (snapshot?.data?.qiblahOffset ?? 0) / 360,
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Transform.scale(
                            scale:
                                0.5, // Adjust the scale factor as needed (e.g., 0.5 for 50% scale)
                            child: SvgPicture.asset(
                              'assets/images/needle.svg',
                              fit: BoxFit.contain,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
