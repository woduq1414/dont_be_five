import 'dart:convert';
import 'package:dont_be_five/data/global.dart';
import 'package:dont_be_five/page/GamePage.dart';
import 'package:dont_be_five/page/HomePage.dart';
import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import 'package:touchable/touchable.dart';




//...



void main() {

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.




  @override
  Widget build(BuildContext context) {

    print(levelData);


    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GlobalStatus>(create: (_) => GlobalStatus()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
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
        home:HomePage()
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme
                  .of(context)
                  .textTheme
                  .headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



class MyCoolPage extends StatefulWidget {
  @override
  _MyCoolPageState createState() => _MyCoolPageState();
}

class _MyCoolPageState extends State<MyCoolPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          //wrap CustomPaint with CanvasTouchDetector
          child: CanvasTouchDetector(
            builder: (context) => CustomPaint(
              painter: MyPainter(context),
            ),
          )),
    );
  }
}

class MyPainter extends CustomPainter {
  final BuildContext context;
  MyPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    //Create and use TouchyCanvas to draw
    TouchyCanvas touchyCanvas = TouchyCanvas(context, canvas);

    var blueCircle = Offset(size.width / 2, size.height / 2 - 100);
    var greenCircle = Offset(size.width / 2, size.height / 2 + 100);
    Path path = new Path();
    var data = [Offset(0,0), Offset(100,0), Offset(100,50), Offset(0,50)];

    var points = data;
    print(points);
    path.addPolygon(points, true);
    Paint paint = Paint();
    paint.style = PaintingStyle.fill;
    paint.color = Color.fromRGBO(255, 0, 0, 1.0);
    // touchyCanvas.drawPath(path, paint, onTapDown: (x){print("hello");});
    touchyCanvas.drawCircle(blueCircle, 60, Paint()..color = Colors.blue, onTapDown: (_) {
      print('You clicked BLUE circle');
      print(DateTime.now());
    });

    touchyCanvas.drawCircle(greenCircle, 30, Paint()..color = Colors.green, onLongPressStart: (_) {
      print('long pressed on GREEN circle');
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}