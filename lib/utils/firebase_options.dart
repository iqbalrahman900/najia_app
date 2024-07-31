import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCAQrDqlN7JhQzEq2yl1oIw9auXcTg6uU4',
    appId: '1:830540005785:web:85aeaffd96dc0bce0c9308',
    messagingSenderId: '830540005785',
    projectId: 'najiatv-9a13d',
    authDomain: 'najiatv-9a13d.firebaseapp.com',
    databaseURL: 'https://najiatv-9a13d-default-rtdb.firebaseio.com',
    storageBucket: 'najiatv-9a13d.appspot.com',
    measurementId: 'G-G19BSDCSYY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB2gDLpqtr2InIVJ1fqvKuaZOcLhDH9wow',
    appId: '1:830540005785:android:2a4a554e52ff45f40c9308',
    messagingSenderId: '830540005785',
    projectId: 'najiatv-9a13d',
    databaseURL: 'https://najiatv-9a13d-default-rtdb.firebaseio.com',
    storageBucket: 'najiatv-9a13d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCGdvdq9vwb4e_rxR9njbbFI-mUh2La_24',
    appId: '1:830540005785:ios:9e5ea4d8cba79cba0c9308',
    messagingSenderId: '830540005785',
    projectId: 'najiatv-9a13d',
    databaseURL: 'https://najiatv-9a13d-default-rtdb.firebaseio.com',
    storageBucket: 'najiatv-9a13d.appspot.com',
    iosBundleId: 'my.com.najia.najiaapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCGdvdq9vwb4e_rxR9njbbFI-mUh2La_24',
    appId: '1:830540005785:ios:1da69f2dd745e6500c9308',
    messagingSenderId: '830540005785',
    projectId: 'najiatv-9a13d',
    databaseURL: 'https://najiatv-9a13d-default-rtdb.firebaseio.com',
    storageBucket: 'najiatv-9a13d.appspot.com',
    iosBundleId: 'my.com.najia.najia.RunnerTests',
  );
}
