// import 'dart:typed_data';
// import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:fastdb/fastdb.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FastDB.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final files = FastDB.getBytesList('files');
    // final profilePic = FastDB.getBytes('profilePicture');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('FastDB Example'),
          centerTitle: true,
        ),
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              // if (profilePic != null && profilePic.isNotEmpty)
              //   Image.memory(Uint8List.fromList(profilePic)),
              Text("Message: ${FastDB.getString('message') ?? 'No data'}"),
              Text(
                  "Username: ${FastDB.getString('username') ?? 'No Data'}"), // Output: john_doe
              Text("Age: ${FastDB.getShort('age')}"), // Output: 30
              Text("Height: ${FastDB.getFloat('height')}"), // Output: 5.9
              Text("IsAdmin: ${FastDB.getBool('isAdmin')}"), // Output: true
              Text(
                  "Tags: ${FastDB.getListString('tags') ?? [].join(',')}"), // Output: [dart, flutter]
              Text(
                  "Scores: ${FastDB.getListShort('scores') ?? [].join(',')}"), // Output: [100, 95, 85]
              Text(
                  "Strike Rate: ${FastDB.getListFloat('strike_rate')}"), // Output: [36.6, 37.0, 36.8]
              Text(
                  "Attendence: ${FastDB.getListBool('attendence')}"), // Output: [true, false, true]
              // if (files != null)
              //   SizedBox(
              //     width: MediaQuery.of(context).size.width,
              //     child: Row(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         for (final file in files)
              //           Image.memory(Uint8List.fromList(file),
              //               fit: BoxFit.contain,
              //               width: (MediaQuery.of(context).size).width /
              //                   files.length),
              //       ],
              //     ),
              //   ),
            ],
          ),
        )),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: writeData,
          icon: Icon(Icons.add),
          label: Text("Add Data"),
        ),
      ),
    );
  }

  Future<void> writeData() async {
    await FastDB.putString('message', 'Give FastDB A Try!! 🎸🤘');
    await FastDB.putString('username', 'john_doe');
    FastDB.putShort('age', 30);
    FastDB.putFloat('height', 5.9);
    FastDB.putBool('isAdmin', true);
    // FastDB.setBytes('profilePicture',
    //     (await rootBundle.load('assets/profile.jpeg')).buffer.asUint8List());
    FastDB.putListString('tags', ['dart', 'flutter']);
    FastDB.putListShort('scores', [100, 95, 85]);
    FastDB.putListFloat('strike_rate', [36.6, 37.0, 36.8]);
    FastDB.putListBool('attendence', [true, false, true]);
    FastDB.flush();
    // FastDB.setBytesList('files', [
    //   (await rootBundle.load('assets/profile.jpeg')).buffer.asUint8List(),
    //   (await rootBundle.load('assets/logo.jpeg')).buffer.asUint8List(),
    //   (await rootBundle.load('assets/file1.jpeg')).buffer.asUint8List(),
    //   (await rootBundle.load('assets/file2.jpeg')).buffer.asUint8List(),
    // ]);
    setState(() {});
  }
}
