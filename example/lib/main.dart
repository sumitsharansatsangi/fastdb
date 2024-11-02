import 'package:fastdb/fastdb.dart';
import 'package:flutter/material.dart';
import 'package:security_info/security_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int age = 0;
  String name = "";
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async => await SecurityInfo.generateSecureKey("fastdb_demo"));
    Future.delayed(Duration.zero, () async => await SecurityInfo.savePin("985623"));
    Future.delayed(Duration.zero, () async => await FastDB.init("fastdb_demo", "985623"));
    Future.delayed(Duration.zero, () async => await FastDB.put("Name","Sumit Kumar"));
    Future.delayed(Duration.zero, () async {
      age = await FastDB.get("Age");
    });
    Future.delayed(Duration.zero, () async {
      name =  await FastDB.get("Age");
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
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text("Age is $age"),
            Text("Name: $name")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
