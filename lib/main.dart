import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kwayes/localization/demo_localization.dart';
import 'package:kwayes/model/user.dart';
import 'package:kwayes/screens/forget_password_screen.dart';
import 'package:kwayes/screens/log_in_screen.dart';
import 'package:kwayes/screens/sign_up_screen.dart';
import 'package:kwayes/screens/splash_screen.dart';
import 'package:kwayes/screens/success_forget_password_screen.dart';
import 'package:kwayes/screens/welcome_screen.dart';
import 'package:kwayes/services/auth.dart';
import 'package:kwayes/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

List<CameraDescription> cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  cameras = await availableCameras();
  runApp(MyApp());
}

var routes = <String, WidgetBuilder>{
  '/Welcome': (BuildContext context) => WelcomeScreen(),
  '/Login': (BuildContext context) => LogInScreen(),
  '/SignUp': (BuildContext context) => SignUpScreen(),
  '/ForgetPassowrd': (BuildContext context) => ForgetPasswordScreen(),
  '/SucccessForgetPassowrd': (BuildContext context) =>
      SucccessForgetPasswordScreen(),
  '/Wrapper': (BuildContext context) => Wrapper(
        cameras: cameras,
      ),
};

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Userr>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: _locale,
        localizationsDelegates: [
          DemoLoacalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('ar', 'EG'),
        ],
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          for (var locale in supportedLocales) {
            if (locale.languageCode == deviceLocale.languageCode &&
                locale.countryCode == deviceLocale.countryCode) {
              return deviceLocale;
            }
          }
          return supportedLocales.first;
        },
        routes: routes,
        home: SplashScreen(),
      ),
    );
  }
}
