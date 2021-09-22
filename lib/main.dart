import 'dart:convert';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:dont_be_five/common/Font.dart';
import 'package:dont_be_five/data/global.dart';
import 'package:dont_be_five/page/CustomLevelSelectPage.dart';
import 'package:dont_be_five/page/GamePage.dart';
import 'package:dont_be_five/page/HomePage.dart';

import 'package:dont_be_five/page/TestPage.dart';
import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart';
import 'package:touchable/touchable.dart';
import 'package:hive/hive.dart';

import 'package:games_services/games_services.dart';

import 'common/firebase.dart';

int beepSoundId;
// class _Handler extends WidgetsBindingObserver {
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       AudioPlayer.resume(); // Audio player is a custom class with resume and pause static methods
//     } else {
//       AudioPlayer.pause();
//     }
//   }
// }
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // WidgetsBinding.instance.addObserver(new _Handler());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    GamesServices.signIn();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GlobalStatus>(create: (_) => GlobalStatus()),
      ],
      child: StyledToast(
        locale: const Locale('en', 'US'),
        //You have to set this parameters to your locale
        textStyle: TextStyle(fontSize: 16.0, color: Colors.white),
        //Default text style of toast
        backgroundColor: Colors.grey.withOpacity(0.5),
        //Background color of toast
        borderRadius: BorderRadius.circular(25.0),
        //Border radius of toast

        textPadding: EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0),
        //The padding of toast text
        toastPositions: StyledToastPosition.top,
        //The position of toast
        toastAnimation: StyledToastAnimation.slideFromBottomFade,
        //The animation type of toast
        reverseAnimation: StyledToastAnimation.fade,
        //The reverse animation of toast (display When dismiss toast)
        curve: Curves.fastOutSlowIn,
        //The curve of animation
        reverseCurve: Curves.fastLinearToSlowEaseIn,
        //The curve of reverse animation
        duration: Duration(seconds: 2),
        //The duration of toast showing
        animDuration: Duration(seconds: 1),
        //The duration of animation(including reverse) of toast
        dismissOtherOnShow: true,
        //When we show a toast and other toast is showing, dismiss any other showing toast before.
        movingOnWindowChange: true,
        //When the window configuration changes, move the toast.
        fullWidth: false,
        //Whether the toast is full screen (subtract the horizontal margin)
        child: MaterialApp(
          routes: {
            "/CustomLevelSelectPage": (context) => CustomLevelSelectPage(),
          },
          debugShowCheckedModeBanner: false,
          title: "Don't Be Five",
          theme: ThemeData(
            fontFamily: Font.light,
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
            // This makes the visual density adapt to the platform that you run
            // the app on. For desktop platforms, the controls will be smaller and
            // closer together (more dense) than on mobile platforms.
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return HomePage();
            },
          ),
        ),
      ),
    );
  }
}
