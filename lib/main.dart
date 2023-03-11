import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:smart_shala/views/logoptions.dart';
import 'constants/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'SmartShala',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: AnimatedSplashScreen(
      duration: 1500,
      splashIconSize: 300,
      splashTransition: SplashTransition.fadeTransition,
      splash: Center(
        child: Image.asset('images/logo.png'),
      ),
      // if logged in, redirect to main page, else to login page
      nextScreen: const PrevLogin(),
    ),
    onGenerateRoute: RouteGenerator.generateRoute,
  ));
}
