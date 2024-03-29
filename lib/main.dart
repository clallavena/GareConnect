import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gare_connect/src/controllers/api_controller.dart';
import 'package:gare_connect/src/model/pto_model.dart';
import 'package:gare_connect/src/model/stop_area_model.dart';

import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

Future main() async{
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiController _apiController = ApiController(); // Initialize the ApiController

  List<StopArea> result = []; // Variable to store the result from the API

  @override
  void initState() {
    super.initState();
    //_fetchStopAreas(); // Call the API when the widget is initialized
  }

  Future<void> _fetchStopAreas() async {
    try {
      final Pto? stopAreas = await _apiController.getStopAreas(http.Client());

      if (stopAreas != null && stopAreas.stopAreas != null) {
        setState(() {
          result = stopAreas.stopAreas!;
        });
      } else {
        setState(() {
          result = [];
          developer.log('result is empty');
        });
      }
    } catch (e) {
      setState(() {
        developer.log('[ERROR] $e');
        result = []; // Handle API call errors
      });
    }
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
            const Text(
              'API Result',
            ),
            Expanded(
                child: result.isNotEmpty ? ListView.builder(
                    itemCount: result.length,
                    itemBuilder: (context, index) {
                      final stopArea = result[index];
                      return ListTile(
                        title: Text(stopArea.name),
                        subtitle: Text(stopArea.label),
                      );
                    },
                )
            :const Center(
                  child: Text('No data to display.'),
                ),
            ),
            ElevatedButton(onPressed: _fetchStopAreas, child: const Text('Fetch stop Area')),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
