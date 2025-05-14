import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:signrecognizer/pages/welcome_page.dart';
import 'firebase_options.dart';
import 'package:camera/camera.dart';
import 'providers/locale_provider.dart';
import 'package:signrecognizer/l10n/app_localizations.dart';
import 'widgets/language_switcher.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Get available cameras
  cameras = await availableCameras();

  runApp(
    ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      child: const SignRecognizerApp(),
    ),
  );
}

class SignRecognizerApp extends StatelessWidget {
  const SignRecognizerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        // Determine text direction based on locale
        final textDirection =
        localeProvider.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: localeProvider.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('fr'),
            Locale('ar'),
          ],
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            scaffoldBackgroundColor: Colors.grey[100],
          ),
          // Use Builder to ensure context has access to localization delegates
          home: Builder(
            builder: (BuildContext context) {
              return Directionality(
                textDirection: textDirection,
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.deepPurple.withOpacity(0.8),
                    title: Text(
                      AppLocalizations.of(context)!.appTitle,
                      style: const TextStyle(color: Colors.white),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LanguageSwitcher(textColor: Colors.white),
                      ),
                    ],
                  ),
                  body: WelcomePage(cameras: cameras),
                ),
              );
            },
          ),
        );
      },
    );
  }
}