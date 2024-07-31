import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:najia/utils/constant.dart';
import 'package:najia/screens/najiatv/najiatv.dart';

class NajiaTVLogin extends StatefulWidget {
  NajiaTVLogin({Key? key}) : super(key: key);

  @override
  _NajiaTVLoginState createState() => _NajiaTVLoginState();
}

class _NajiaTVLoginState extends State<NajiaTVLogin> {
  TextEditingController masjidIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void onConnectButtonPressed(BuildContext context) async {
    final masjidId = masjidIdController.text;
    final password = passwordController.text;

    try {
      // Sign in with email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: masjidId,
        password: password,
      );

      // If the sign-in is successful, you can navigate to another screen or perform other actions.
      // For example, you can use Navigator to navigate to a new screen:
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => NajiaTV()));
    } catch (e) {
      // Handle sign-in errors here, e.g., show an error message to the user
      print('Sign-in error: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Sorry, invalid credentials!"),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Close",
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      // You can display an error message to the user here.
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final imageWidth = mediaQuery.size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: NajiaColors.bgColor,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 0,
        title: const Text(
          "NAJIA TV CONNECT",
          style: TextStyle(fontSize: 12, letterSpacing: 8, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0), // Round corners
                    child: Image.asset(
                      'assets/images/ntvimg.png',
                      fit: BoxFit.cover, // Full width
                      width: imageWidth,
                      height: imageWidth,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                  child: TextField(
                    controller: masjidIdController,
                    cursorColor: NajiaColors.black,
                    decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: NajiaColors.black),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: NajiaColors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: NajiaColors.black),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                              width: 1,
                            )),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: NajiaColors.black)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: NajiaColors.black)),
                        labelText: 'Mosque Email Address',
                        labelStyle: TextStyle(
                          color: NajiaColors.black,
                        ),
                        hintText: 'Enter email address'),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 15, right: 20.0, left: 20.0),
                  child: TextField(
                    controller: passwordController,
                    cursorColor: NajiaColors.black,
                    obscureText:
                        !isPasswordVisible, // Hide or show password based on the flag

                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: NajiaColors.black,
                          ),
                          onPressed: togglePasswordVisibility,
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: NajiaColors.black),
                        ),
                        disabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: NajiaColors.black),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: NajiaColors.black),
                        ),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                              width: 1,
                            )),
                        errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: NajiaColors.black)),
                        focusedErrorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: NajiaColors.black)),
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                          color: NajiaColors.black,
                        ),
                        hintText: 'Enter password'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: NajiaColors.black,
                      ),
                      onPressed: () => onConnectButtonPressed(context),
                      child: const Text("Connect"),
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
