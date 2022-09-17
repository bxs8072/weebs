import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:freeforweebs/firebase_options.dart';
import 'package:freeforweebs/resources/theme_tool.dart';
import 'package:freeforweebs/screens/landing_screen/landing_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:theme_provider/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Weebs());
}

class Weebs extends StatelessWidget {
  const Weebs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      defaultThemeId: ThemeTool.dark,
      loadThemeOnInit: true,
      saveThemesOnChange: true,
      themes: [
        AppTheme.purple(id: ThemeTool.light),
        AppTheme.dark(id: ThemeTool.dark),
      ],
      child: ThemeConsumer(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ThemeConsumer(
            child: LandingScreen(key: key),
          ),
        ),
      ),
    );
  }
}
