import 'package:flutter/material.dart';
import 'package:flutter_app_test/counter.dart';
import 'package:flutter_app_test/numbers_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 25, 149, 151)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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
  int _value = 0;
  bool _isLoading = false;

  Future<void> _getRandomValue() async {
    setState(() {
      _isLoading = true;
    });
    final NumbersService numberService = NumbersService.filled();
    final int randomInt = await numberService.getRandomInt();
    setState(() {
      _isLoading = false;
      _value = randomInt;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Random value is:',
              ),
              Counter(_value)
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _getRandomValue,
          tooltip: 'Get random value',
          child: getLoader(),
        ));
  }

  Widget getLoader() {
    if (_isLoading) {
      return const Icon(Icons.loop);
    } else {
      return const Icon(Icons.refresh);
    }
  }
}
