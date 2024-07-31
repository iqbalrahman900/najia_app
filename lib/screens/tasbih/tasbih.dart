import 'package:flutter/material.dart';
import 'package:najia/utils/constant.dart';
import 'package:vibration/vibration.dart';

class Tasbih extends StatefulWidget {
  const Tasbih({super.key});

  @override
  State<Tasbih> createState() => _TasbihState();
}

class _TasbihState extends State<Tasbih> {
  int _counter = 0;
  int _targetValue = 10;
  String buttonText = 'Vibrate after 10x';

  void _incrementCounter() {
    setState(() {
      _counter++;
      if (_counter % _targetValue == 0) {
        _vibrate(); // Vibrate when the counter is a multiple of the target value
      }
    });
  }

  Future<void> _vibrate() async {
    Vibration.vibrate();
  }

  void _toggleTargetValue(context) {
    setState(() {
      if (_targetValue == 10) {
        _targetValue = 33;
        buttonText = 'Vibrate after 33x';
      } else if (_targetValue == 33) {
        _targetValue = 100;
        buttonText = 'Vibrate after 100x';
      } else {
        _targetValue = 10;
        buttonText = 'Vibrate after 10x';
      }
      _showToast(context, _targetValue.toString());

      _counter = 0; // Reset the counter when the target value changes
    });
  }

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
          "TASBIH DIGITAL",
          style: TextStyle(
            fontSize: 12,
            letterSpacing: 8,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(height: 2, fontFamily: 'naskh', fontSize: 26),
                  "يَا أَيُّهَا الَّذِينَ آمَنُوا اذْكُرُوا اللَّهَ ذِكْرًا كَثِيرًا"),
              Text(
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 1.5, fontSize: 14),
                  "\nO you who believe! Remember Allah\nwith much remembrance.\n\nAl-Ahzab: 41"),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: InkWell(
              onTap: () => {_incrementCounter()},
              child: Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: NajiaColors.bgColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Text(
                    '$_counter',
                    style: const TextStyle(
                      fontSize: 50,
                      color: Color.fromARGB(255, 232, 191, 147),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.black,
          //   ),
          //   onPressed: () => _toggleTargetValue(context),
          //   child: Text(_buttonText),
          // ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}

void _showToast(BuildContext context, String data) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text('${'Tasbih is set to vibrate after every $data'} times'),
      backgroundColor: NajiaColors.black,
    ),
  );
}
