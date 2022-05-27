import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_registration/features/login/login_page.dart';
import 'package:user_registration/shared/theme/theme.dart';
import 'package:user_registration/shared/utils/my_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyPreferences().initialize();
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const LoginPage(),
    );
  }
}
