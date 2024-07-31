// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:theme_provider/theme_provider.dart';

// class SettingTheme extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var controller = ThemeProvider.controllerOf(context);

//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _buildButton(
//               text: "Next Theme",
//               onPressed: controller.nextTheme,
//             ),
//             _buildButton(
//               text: "Theme Dialog",
//               onPressed: () {
//                 showDialog(context: context, builder: (_) => ThemeDialog());
//               },
//             ),
//             Text('Current theme: ${controller.theme.id}'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildButton({required String text, VoidCallback? onPressed}) {
//     return Padding(
//       padding: const EdgeInsets.all(4.0),
//       child: ElevatedButton(
//         child: Text(text),
//         onPressed: onPressed,
//       ),
//     );
//   }
// }
