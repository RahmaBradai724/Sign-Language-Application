import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:signrecognizer/pages/welcome_page.dart';
import 'firebase_options.dart';
import 'package:camera/camera.dart';
import 'pages/login_page.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Get available cameras
  cameras = await availableCameras();

  runApp(SignRecognizerApp());
}

class SignRecognizerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reconnaissance de Signes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: WelcomePage(cameras: cameras),
    );
  }
}
