import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:isolate';
import 'dart:io';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

void main() async {
  final encryptionReceivePort = ReceivePort();
  await Isolate.spawn(encryptDecryptData, encryptionReceivePort.sendPort);

  final encryptionSendPort = await encryptionReceivePort.first as SendPort;

  // Securely store key and IV
  await storeKeyAndIv();

  // Encrypt data
  // final dataToEncrypt = 'Hello, World!';

final dataToEncrypt = {'message': 'Give FastDB A Try!! 🎸🤘', 'username': 'john_doe',
   'age': 30,'height': 5.9, 'isAdmin': true,'tags': ['dart', 'flutter'],'scores': [100, 95, 85],
   'strike_rate': [36.6, 37.0, 36.8],'attendence': [true, false, true]};
  // final encryptMessage = {
  //   'operation': 'encrypt',
  //   'data': jsonEncode( dataToEncrypt),
  //   'responsePort': encryptionResponsePort.sendPort
  // };
  final encryptedText = await encryptData(jsonEncode(dataToEncrypt), encryptionSendPort);
  print('Encrypted Data: $encryptedText');

  // Write encrypted data to file
  final fileWriter = FileWriter('example_encrypted.txt');
  await fileWriter.write(encryptedText);
  print('File write result: File written successfully.');

  // Read and decrypt data
  final encryptedContent = await fileWriter.read();
  print('Encrypted Content Read from File: $encryptedContent');
  final decryptedText = await decryptData(encryptedContent, encryptionSendPort);
  print('Decrypted Data: $decryptedText');
}

Future<void> storeKeyAndIv() async {
  final key = encrypt.Key.fromSecureRandom(32);
  final iv = encrypt.IV.fromSecureRandom(16);

  await storage.write(key: 'encryption_key', value: key.base64);
  await storage.write(key: 'encryption_iv', value: iv.base64);
}

Future<String> encryptData(String data, SendPort sendPort) async {
  final encryptionResponsePort = ReceivePort();
  final key = await storage.read(key: 'encryption_key');
  final iv = await storage.read(key: 'encryption_iv');

  final encryptMessage = {
    'operation': 'encrypt',
    'data': data,
    'key': key,
    'iv': iv,
    'responsePort': encryptionResponsePort.sendPort,
  };
  sendPort.send(encryptMessage);

  final encryptedData = await encryptionResponsePort.first as String;
  return encryptedData;
}

Future<String> decryptData(String data, SendPort sendPort) async {
  final decryptionResponsePort = ReceivePort();
  final key = await storage.read(key: 'encryption_key');
  final iv = await storage.read(key: 'encryption_iv');

  final decryptMessage = {
    'operation': 'decrypt',
    'data': data,
    'key': key,
    'iv': iv,
    'responsePort': decryptionResponsePort.sendPort,
  };
  sendPort.send(decryptMessage);

  final decryptedData = await decryptionResponsePort.first as String;
  return decryptedData;
}

void encryptDecryptData(SendPort sendPort) {
  final port = ReceivePort();
  sendPort.send(port.sendPort);

  port.listen((message) {
    final operation = message['operation'] as String;
    final data = message['data'] as String;
    final responsePort = message['responsePort'] as SendPort;
    final key = encrypt.Key.fromBase64(message['key'] as String);
    final iv = encrypt.IV.fromBase64(message['iv'] as String);

    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));

    try {
      if (operation == 'encrypt') {
        final encrypted = encrypter.encrypt(data, iv: iv);
        responsePort.send(encrypted.base64);
      } else if (operation == 'decrypt') {
        final encrypted = encrypt.Encrypted.fromBase64(data);
        final decrypted = encrypter.decrypt(encrypted, iv: iv);
        responsePort.send(decrypted);
      }
    } catch (e) {
      responsePort.send('Error: $e');
    }
  });
}

class FileWriter {
  final String path;
  final Queue<Function> _writeQueue = Queue<Function>();
  bool _isWriting = false;

  FileWriter(this.path);

  Future<void> write(String content) async {
    final Completer<void> completer = Completer<void>();

    _writeQueue.add(() async {
      final file = File(path);
      await file.writeAsString(content, mode: FileMode.write);
      completer.complete();
    });

    _processQueue();
    return completer.future;
  }

  Future<String> read() async {
    final Completer<String> completer = Completer<String>();

    _writeQueue.add(() async {
      final file = File(path);
      final content = await file.readAsString();
      completer.complete(content);
    });

    _processQueue();
    return completer.future;
  }

  void _processQueue() async {
    if (_isWriting || _writeQueue.isEmpty) return;

    _isWriting = true;
    final writeOperation = _writeQueue.removeFirst();
    await writeOperation();
    _isWriting = false;

    _processQueue(); // Check the queue for more operations
  }
}
