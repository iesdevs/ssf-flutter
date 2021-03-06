import 'package:flutter/material.dart';
import 'blueman.dart';

BlueMan blueMan = BlueMan();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ssf @ zenith',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'BlueTooth Social Safety'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _counter;

  void _incrementCounter() async {
    _counter = await blueMan.blueCheck();
    setState(() {
      _counter += ' :end';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          elevation: 10.0,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Safety Level',
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(
                  height: 100.0,
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(
                  height: 120.0,
                ),
                Text(
                  'Note: Please keep the Bluetooth swithced on to assure your safety.',
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Scan',
        child: Icon(Icons.replay),
      ),
    );
  }
}
