import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Nego extends StatefulWidget {
  @override
  _NegoState createState() => _NegoState();
}

class _NegoState extends State<Nego> {
  TextEditingController textController = TextEditingController();
  List<String> translations = [];

  Future<void> translate(String input) async {
    final apiKey = "YOUR_OPENAI_API_KEY"; // Replace with your OpenAI API key
    final endpoint = "https://api.openai.com/v1/engines/gpt-3.5-turbo/completions";

    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey",
    };

    final data = {
      "messages": [
        {"role": "user", "content": "Translate the following English text to Malaysian Malay (Not Indonesia):"},
        {"role": "user", "content": input},
      ],
    };

    final response = await http.post(
      Uri.parse(endpoint),
      headers: headers,
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final reply = responseData["choices"][0]["message"]["content"];
      setState(() {
        translations.add(reply);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Translation App"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                labelText: "Enter English text",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final input = textController.text;
              if (input.isNotEmpty) {
                translate(input);
                textController.clear();
              }
            },
            child: Text("Translate"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: translations.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("Malay output: ${translations[index]}"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
