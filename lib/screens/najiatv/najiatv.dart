import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:najia/utils/constant.dart';
import 'package:najia/screens/najiatv/add_event.dart';
import 'package:najia/screens/quran/quran_choose/choose_surah.dart';
import 'package:najia/screens/splashscreen/splashscreen.dart';

class NajiaTV extends StatefulWidget {
  NajiaTV({Key? key}) : super(key: key);

  @override
  _NajiaTVState createState() => _NajiaTVState();
}

class _NajiaTVState extends State<NajiaTV> {
  List<Event> fakeEvents = [
    Event(
      eventId: '1',
      date: '06 October 2023',
      startTime: '4:21 PM',
      endTime: '4:21 PM',
      eventName: 'Sample Event 1',
      speakerName: 'Sample Speaker 1',
      placeName: 'Sample Place 1',
    ),
    Event(
      eventId: '2',
      date: '07 October 2023',
      startTime: '5:30 PM',
      endTime: '6:30 PM',
      eventName: 'Sample Event 2',
      speakerName: 'Sample Speaker 2',
      placeName: 'Sample Place 2',
    ),
    // Add more fake events as needed
  ];

  var eventsList = [];

  var ev = "N/A";

  var userEmail = "N/A";
  var trimmedEmail = "N/A";

  // INFO
  var pic = "N/A";
  var mosqueName = "N/A";
  var contact = "N/A";

  // DONATION
  var bankName = "N/A";
  var bankAcc = "N/A";
  var bankAccName = "N/A";
  var donationDesc = "N/A";
  var currAmt = "N/A";

  // KHUTBAH
  var khutbahTitle = "N/A";

  // ROLLING TEXT
  var rollText = "N/A";

  // ANNOUNCEMENT
  var announcement = "N/A";

  @override
  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      userEmail = user?.email ?? 'No email';
    });
    String firstPartEmail = userEmail.split('@')[0];
    trimmedEmail = firstPartEmail.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
    _startDataSubscription();
    fetchEvents();
  }

  _startDataSubscription() {
    final databaseReference = FirebaseDatabase.instance.ref();

    databaseReference.child('$trimmedEmail/info/pic').onValue.listen((event) {
      setState(() {
        pic = event.snapshot.value.toString();
      });
    });

    databaseReference
        .child('$trimmedEmail/info/mosque_name')
        .onValue
        .listen((event) {
      setState(() {
        mosqueName = event.snapshot.value.toString();
      });
    });

    databaseReference
        .child('$trimmedEmail/info/contact')
        .onValue
        .listen((event) {
      setState(() {
        contact = event.snapshot.value.toString();
      });
    });

    databaseReference
        .child('$trimmedEmail/rolltext/rolltext')
        .onValue
        .listen((event) {
      setState(() {
        rollText = event.snapshot.value.toString();
      });
    });

    databaseReference
        .child('$trimmedEmail/announcement/announcement')
        .onValue
        .listen((event) {
      setState(() {
        announcement = event.snapshot.value.toString();
      });
    });

    //DONATION
    databaseReference
        .child('$trimmedEmail/donation/bankAcc')
        .onValue
        .listen((event) {
      setState(() {
        bankAcc = event.snapshot.value.toString();
      });
    });
    databaseReference
        .child('$trimmedEmail/donation/bankAccName')
        .onValue
        .listen((event) {
      setState(() {
        bankAccName = event.snapshot.value.toString();
      });
    });
    databaseReference
        .child('$trimmedEmail/donation/bankName')
        .onValue
        .listen((event) {
      setState(() {
        bankName = event.snapshot.value.toString();
      });
    });
    databaseReference
        .child('$trimmedEmail/donation/currAmt')
        .onValue
        .listen((event) {
      setState(() {
        currAmt = event.snapshot.value.toString();
      });
    });
    databaseReference
        .child('$trimmedEmail/donation/donationDesc')
        .onValue
        .listen((event) {
      setState(() {
        donationDesc = event.snapshot.value.toString();
      });
    });

    // KHUTBAH
    databaseReference
        .child('$trimmedEmail/khutbah/title')
        .onValue
        .listen((event) {
      setState(() {
        khutbahTitle = event.snapshot.value.toString();
      });
    });

    // ANNOUNCEMENT
    databaseReference
        .child('$trimmedEmail/announcement/announcement')
        .onValue
        .listen((event) {
      setState(() {
        khutbahTitle = event.snapshot.value.toString();
      });
    });
  }

  Future<void> fetchEvents() async {
    final databaseReference = FirebaseDatabase.instance.ref();
    final eventsData =
        await databaseReference.child('$trimmedEmail/events').once();

    for (var child in eventsData.snapshot.children) {
      final eventMap = child.value as Map<dynamic, dynamic>;
      final placeName = eventMap['placeName'];
      final startTime = eventMap['startTime'];
      final endTime = eventMap['endTime'];
      final eventName = eventMap['eventName'];
      final speakerName = eventMap['speakerName'];
      final date = eventMap['date'];

      final formattedEvent = '''
      Place Name: $placeName
      Start Time: $startTime
      End Time: $endTime
      Event Name: $eventName
      Speaker Name: $speakerName
      Date: $date
    ''';

      if (kDebugMode) {
        print(formattedEvent);
      }
    }
  }

  _startEventsSubscription() {
    final databaseReference = FirebaseDatabase.instance.ref();
    databaseReference.child('$trimmedEmail/events').onValue.listen((event) {
      final eventsData = event.snapshot.value;
      print('Retrieved data: $eventsData');
      if (eventsData != null && eventsData is Map<String, dynamic>) {
        final List<Event> events = [];
        eventsData.forEach((eventId, eventData) {
          final event = Event(
            eventId: eventId,
            date: eventData['date'] ?? '',
            startTime: eventData['startTime'] ?? '',
            endTime: eventData['endTime'] ?? '',
            eventName: eventData['eventName'] ?? '',
            speakerName: eventData['speakerName'] ?? '',
            placeName: eventData['placeName'] ?? '',
          );
          events.add(event);
        });
        setState(() {
          eventsList = events;
        });
      }
    });
  }

  void _stopDataSubscription() {
    // Since you're not storing the subscription, there's nothing to cancel here
  }

  void _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const SplashScreen(),
        ),
        (route) => false,
      );
    } catch (e) {
      // Handle sign-out errors if any
      if (kDebugMode) {
        print("Error signing out: $e");
      }
    }
  }

  void _handleEditClick(BuildContext context, String userEmail, String category,
      String field, String currData) {
    TextEditingController textEditingController =
        TextEditingController(text: currData);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit $field"),
          content: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: "Enter new $field",
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Save"),
              onPressed: () {
                String newValue = textEditingController.text;

                final databaseReference = FirebaseDatabase.instance.ref();
                databaseReference
                    .child('$userEmail/$category/$field')
                    .set(newValue);

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
          "NAJIA TV",
          style: TextStyle(fontSize: 12, letterSpacing: 8, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              // Display the user's email
              CollapsibleCard(
                title: "Mosque Information",
                isExpandedByDefault:
                    true, // Set to true if you want it expanded by default
                children: [
                  ListTile(
                    title: Text("Email address"),
                    subtitle: Text(userEmail),
                  ),
                  ListTile(
                    title: Text("Person in Charge"),
                    subtitle: Text(pic),
                    trailing: InkWell(
                      onTap: () => _handleEditClick(context, trimmedEmail,
                          "info", "pic", pic), // Pass the field name
                      child: Icon(Icons.edit),
                    ),
                  ),
                  ListTile(
                    title: Text("Contact Number"),
                    subtitle: Text(contact),
                    trailing: InkWell(
                      onTap: () => _handleEditClick(context, trimmedEmail,
                          "info", "contact", contact), // Pass the field name
                      child: Icon(Icons.edit),
                    ),
                  ),
                  ListTile(
                    title: Text("Mosque Name"),
                    subtitle: Text(mosqueName),
                    trailing: InkWell(
                      onTap: () => _handleEditClick(
                          context,
                          trimmedEmail,
                          "info",
                          "mosque_name",
                          mosqueName), // Pass the field name
                      child: Icon(Icons.edit),
                    ),
                  ),
                ],
              ),
              CollapsibleCard(
                title: "Collection Information",
                isExpandedByDefault:
                    true, // Set to true if you want it expanded by default
                children: [
                  ListTile(
                    title: Text("Collection Type"),
                    subtitle: Text(bankName),
                    trailing: InkWell(
                      onTap: () => _handleEditClick(
                          context,
                          trimmedEmail,
                          "donation",
                          "bankName",
                          bankName), // Pass the field name
                      child: Icon(Icons.edit),
                    ),
                  ),
                  ListTile(
                    title: Text("Account Number"),
                    subtitle: Text(bankAcc),
                    trailing: InkWell(
                      onTap: () => _handleEditClick(
                          context,
                          trimmedEmail,
                          "donation",
                          "bankAcc",
                          bankAcc), // Pass the field name
                      child: Icon(Icons.edit),
                    ),
                  ),
                  ListTile(
                    title: Text("Account Holder Name"),
                    subtitle: Text(bankAccName),
                    trailing: InkWell(
                      onTap: () => _handleEditClick(
                          context,
                          trimmedEmail,
                          "donation",
                          "bankAccName",
                          bankAccName), // Pass the field name
                      child: Icon(Icons.edit),
                    ),
                  ),
                  ListTile(
                    title: Text("Collection Description"),
                    subtitle: Text(donationDesc),
                    trailing: InkWell(
                      onTap: () => _handleEditClick(
                          context,
                          trimmedEmail,
                          "donation",
                          "donationDesc",
                          donationDesc), // Pass the field name
                      child: Icon(Icons.edit),
                    ),
                  ),
                  ListTile(
                    title: Text("Current Collection"),
                    subtitle: Text(currAmt),
                    trailing: InkWell(
                      onTap: () => _handleEditClick(
                          context,
                          trimmedEmail,
                          "donation",
                          "currAmt",
                          currAmt), // Pass the field name
                      child: Icon(Icons.edit),
                    ),
                  ),
                ],
              ),
              CollapsibleCard(
                title: "Rolling Text",
                isExpandedByDefault:
                    false, // Set to true if you want it expanded by default
                children: [
                  ListTile(
                    title: Text("Value: $rollText"),
                    trailing: InkWell(
                      onTap: () => _handleEditClick(
                          context,
                          trimmedEmail,
                          "rolltext",
                          "rolltext",
                          rollText), // Pass the field name
                      child: Icon(Icons.edit),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: NajiaColors.black,
                        ),
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ChooseSurah(), // Replace ChooseSurah with the actual name of your destination screen
                            ),
                          ),
                        },
                        child: const Text("Add Rolling Text"),
                      ),
                    ),
                  ),
                ],
              ),

              CollapsibleCard(
                title: "Ayat Quran",
                isExpandedByDefault:
                    false, // Set to true if you want it expanded by default
                children: [
                  // ListTile(
                  //   title: Text("Surah Ar-Rahman"),
                  //   subtitle: Text("Ayat 13"),
                  // ),
                  // ListTile(
                  //   title: Text("Surah Al-Baqarah"),
                  //   subtitle: Text("Ayat 197"),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: NajiaColors.black,
                        ),
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ChooseSurah(), // Replace ChooseSurah with the actual name of your destination screen
                            ),
                          ),
                        },
                        child: const Text("Add Ayat Quran"),
                      ),
                    ),
                  ),
                ],
              ),
              CollapsibleCard(
                title: "Events",
                isExpandedByDefault: false,
                children: [
                  // Text(eventsList.first.speakerName.toString()),
                  // Replace this with a ListView.builder to display a list of events
                  Container(
                    height: 20,
                    width: double.infinity, // Define a height or use Expanded
                    child: ListView.builder(
                      itemCount: fakeEvents.length,
                      itemBuilder: (context, index) {
                        final event = fakeEvents[index];
                        return ListTile(
                          title: Text(event.eventName),
                          subtitle: Text(event.date),
                          // Add any other event information you want to display here
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: NajiaColors.black,
                        ),
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => AddEvent(),
                            ),
                          ),
                        },
                        child: const Text("Add Event"),
                      ),
                    ),
                  ),
                ],
              ),
              CollapsibleCard(
                title: "Announcement",
                isExpandedByDefault:
                    false, // Set to true if you want it expanded by default
                children: [
                  ListTile(
                    title: Text("Value: $announcement"),
                    trailing: InkWell(
                      onTap: () => _handleEditClick(
                          context,
                          trimmedEmail,
                          "announcement",
                          "announcement",
                          announcement), // Pass the field name
                      child: Icon(Icons.edit),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: NajiaColors.black,
                        ),
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ChooseSurah(), // Replace ChooseSurah with the actual name of your destination screen
                            ),
                          ),
                        },
                        child: const Text("Add Ayat Quran"),
                      ),
                    ),
                  ),
                ],
              ),
              CollapsibleCard(
                title: "Khutbah",
                isExpandedByDefault:
                    false, // Set to true if you want it expanded by default
                children: [
                  ListTile(
                    title: Text("Title: $khutbahTitle"),
                    trailing: InkWell(
                      onTap: () => _handleEditClick(
                          context,
                          trimmedEmail,
                          "khutbah",
                          "title",
                          khutbahTitle), // Pass the field name
                      child: Icon(Icons.edit),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: NajiaColors.black,
                        ),
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ChooseSurah(), // Replace ChooseSurah with the actual name of your destination screen
                            ),
                          ),
                        },
                        child: const Text("Add Ayat Quran"),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
              Center(
                child: Container(
                  height: 100,
                  margin: const EdgeInsets.only(bottom: 30),
                  child: const Column(
                    children: [
                      Image(
                          height: 30,
                          image: AssetImage('assets/images/najia_logo.png')),
                      SizedBox(
                        height: 15,
                      ),
                      Text("Najia App Studio"),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Mosque Display System Dashboard.",
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: NajiaColors.black,
                    ),
                    onPressed: () => _signOut(context),
                    child: const Text("Logout"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CollapsibleCard extends StatefulWidget {
  final String title;
  final bool isExpandedByDefault;
  final List<Widget> children;

  const CollapsibleCard({
    required this.title,
    this.isExpandedByDefault = false,
    required this.children,
  });

  @override
  _CollapsibleCardState createState() => _CollapsibleCardState();
}

class _CollapsibleCardState extends State<CollapsibleCard> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpandedByDefault;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          Container(
            color: NajiaColors.bgColor,
            child: ListTile(
              title: Text(widget.title),
              trailing: _isExpanded
                  ? Icon(Icons.expand_less)
                  : Icon(Icons.expand_more),
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          if (_isExpanded)
            Column(
              children: widget.children,
            ),
        ],
      ),
    );
  }
}

Widget eventItem({required Event event}) {
  return Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(10),
    height: 110,
    color: Colors.amberAccent,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          event.eventName,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'Date: ${event.date}',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'Time: ${event.startTime} - ${event.endTime}',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // Add your edit event action here
              },
              child: Row(
                children: [
                  Icon(
                    Icons.edit,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 6,
            ),
            GestureDetector(
              onTap: () {
                // Add your delete event action here
              },
              child: Row(
                children: [
                  Icon(
                    Icons.delete,
                    color: Colors.red[700],
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    ),
  );
}

class Event {
  final String eventId;
  final String date;
  final String startTime;
  final String endTime;
  final String eventName;
  final String speakerName;
  final String placeName;

  Event({
    required this.eventId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.eventName,
    required this.speakerName,
    required this.placeName,
  });
}
