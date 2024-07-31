import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:najia/utils/constant.dart';

class AddEvent extends StatefulWidget {
  AddEvent({Key? key}) : super(key: key);

  @override
  _AddEventState createState() => _AddEventState();
}

Future<void> addEventToDatabase(
  trimmedEmail,
  DateTime selectedDate,
  TimeOfDay startTime,
  TimeOfDay endTime,
  String eventName,
  String speakerName,
  String placeName,
) async {
  final databaseReference = FirebaseDatabase.instance.reference();

  // Create a new event node under '/zahir/events'
  final eventRef = databaseReference.child('$trimmedEmail/events').push();

  // Define the event data
  final eventData = {
    'date': DateFormat('dd MMMM yyyy').format(selectedDate),
    'startTime': formatTimeOfDay(startTime),
    'endTime': formatTimeOfDay(endTime),
    'eventName': eventName,
    'speakerName': speakerName,
    'placeName': placeName,
  };

  // Set the data under the event node
  await eventRef.set(eventData);
}

String formatTimeOfDay(TimeOfDay timeOfDay) {
  final now = DateTime.now();
  final dateTime =
      DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  return DateFormat('h:mm a').format(dateTime);
}

class _AddEventState extends State<AddEvent> {
  var userEmail = "N/A";
  var trimmedEmail = "N/A";

  @override
  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      userEmail = user?.email ?? 'No email';
    });
    String firstPartEmail = userEmail.split('@')[0];
    trimmedEmail = firstPartEmail.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
  }

  DateTime selectedDate = DateTime.now();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  TextEditingController eventNameController = TextEditingController();
  TextEditingController speakerNameController = TextEditingController();
  TextEditingController placeNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: NajiaColors.bgColor,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black, // change your color here
        ),
        elevation: 0,
        title: const Text(
          "ADD EVENT",
          style: TextStyle(fontSize: 12, letterSpacing: 8, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            // Event Name Input
            TextFormField(
              controller: eventNameController,
              decoration: const InputDecoration(
                labelText: 'Event Name',
                labelStyle: TextStyle(color: Colors.black),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter an event name';
                }
                return null;
              },
              style: TextStyle(color: Colors.black),
            ),

            // Speaker Name Input
            TextFormField(
              controller: speakerNameController,
              decoration: const InputDecoration(
                labelText: 'Speaker Name',
                labelStyle: TextStyle(color: Colors.black),
              ),
              style: TextStyle(color: Colors.black),
            ),

            // Place Name Input
            TextFormField(
              controller: placeNameController,
              decoration: const InputDecoration(
                labelText: 'Place Name',
                labelStyle: TextStyle(color: Colors.black),
              ),
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (date != null) {
                    setState(() {
                      selectedDate = date;
                    });
                  }
                },
                child: Text(
                  "Date: ${DateFormat('dd MMMM yyyy').format(selectedDate)}",
                ),
              ),
            ),

            // Time Range Picker
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Time: "),
                TextButton(
                  onPressed: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: startTime,
                    );
                    if (time != null) {
                      setState(() {
                        startTime = time;
                      });
                    }
                  },
                  child: Text(
                    startTime.format(context),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Text(
                  ' to ',
                  style: TextStyle(color: Colors.black),
                ),
                TextButton(
                  onPressed: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: endTime,
                    );
                    if (time != null) {
                      setState(() {
                        endTime = time;
                      });
                    }
                  },
                  child: Text(
                    endTime.format(context),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: NajiaColors.black,
            ),
            onPressed: () {
              final selectedDateStr =
                  DateFormat('dd MMMM yyyy').format(selectedDate);
              final startTimeStr = startTime.format(context);
              final endTimeStr = endTime.format(context);
              final eventName = eventNameController.text;
              final speakerName = speakerNameController.text;
              final placeName = placeNameController.text;

              // Call the function to add data to the database
              addEventToDatabase(
                trimmedEmail,
                selectedDate,
                startTime,
                endTime,
                eventName,
                speakerName,
                placeName,
              );

              // Print the values (optional)
              if (kDebugMode) {
                print('Selected Date: $selectedDateStr');
                print('Start Time: $startTimeStr');
                print('End Time: $endTimeStr');
                print('Event Name: $eventName');
                print('Speaker Name: $speakerName');
                print('Place Name: $placeName');
              }
            },
            child: const Text("Add Event"),
          ),
        ),
      ],
    );
  }
}
