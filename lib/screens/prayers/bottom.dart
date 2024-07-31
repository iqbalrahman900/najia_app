import 'package:flutter/material.dart';

renderBottom() {
  return Container(
    height: 100,
    margin: const EdgeInsets.only(bottom: 20,),
    child: const Column(
      children: [
        Image(height: 30, image: AssetImage('assets/images/najia_logo.png')),
        SizedBox(
          height: 15,
        ),
        Text("Made with ♡ by Najia App Studio"),
        SizedBox(
          height: 3,
        ),
        Text(
          "Copyright 2024",
          style: TextStyle(fontSize: 10),
        ),
      ],
    ),
  );
}
