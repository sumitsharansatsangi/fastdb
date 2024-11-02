library;

import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'fastdb_generated.dart' as db;
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:security_info/security_info.dart';

class FastDB {
  static final FastDB _instance = FastDB._internal();
  factory FastDB() => _instance;
  FastDB._internal();

  static List<db.KeyValueObjectBuilder> keyValueLists = [];
  static late final encrypt.Key _key;
  static late final encrypt.IV _iv;
  static const _ssKey = 'ss';
  static const _svKey = 'sv';
  static const _keyLength = 32;
  static const _ivLength = 16;
  static late File _file;
  static late encrypt.Encrypter _encrypter;

  static Future<void> init(String alias, String pin) async {
    await _initializeKeys(alias, pin);
    final directory = await getApplicationSupportDirectory();
    _file = File('${directory.path}/fastDB.dat');
    if (await _file.exists()) {
      _decryptFile();
    } else {
      await _file.create(recursive: true);
    }
  }

  static Future<void> _decryptFile() async {
    try {
      final bytes = await _file.readAsBytes();
      if (bytes.isNotEmpty) {
        final decrypted =
            _encrypter.decryptBytes(encrypt.Encrypted(bytes), iv: _iv);
        db.KeyValueList fastDB = db.KeyValueList(decrypted);
        for (var l in fastDB.lists!) {
          keyValueLists.add(db.KeyValueObjectBuilder(
              key: l.key!, val: l.val, valType: valType(l.val)));
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> _initializeKeys(String alias, String pin) async {
    final encryptedSSData = await SecurityInfo.getData(alias, pin, _ssKey);
    final encryptedSVData = await SecurityInfo.getData(alias, pin, _svKey);

    if (encryptedSSData == null) {
      _key = encrypt.Key.fromLength(_keyLength);
      await SecurityInfo.saveData(alias, pin, _ssKey, _key.base64);
    } else {
      _key = encrypt.Key.fromBase64(encryptedSSData);
    }
    if (encryptedSVData == null) {
      _iv = encrypt.IV.fromLength(_ivLength);
      await SecurityInfo.saveData(alias, pin, _svKey, _iv.base64);
    } else {
      _iv = encrypt.IV.fromBase64(encryptedSVData);
    }
  }

  static dynamic get(String key) {
    for (final k in keyValueLists) {
      if (k.key == key) {
        return k.val;
      }
    }
  }

  static db.AnyTypeId valType(dynamic val) {
    if (val is String) {
      return db.AnyTypeId.StringWrapper;
    } else if (val is int) {
      return db.AnyTypeId.IntWrapper;
    } else if (val is double) {
      return db.AnyTypeId.DoubleWrapper;
    } else if (val is bool) {
      return db.AnyTypeId.BoolWrapper;
    } else if (val is List<String>) {
      return db.AnyTypeId.ListString;
    } else if (val is List<int>) {
      return db.AnyTypeId.ListInt;
    } else if (val is List<double>) {
      return db.AnyTypeId.ListDouble;
    } else if (val is List<bool>) {
      return db.AnyTypeId.ListBool;
    } else if (val is db.ComplexObject) {
      return db.AnyTypeId.ComplexObject;
    } else {
      throw ArgumentError('Unsupported value type');
    }
  }

  static Future<void> put(String key, dynamic val) async {
    bool flag = true;
    for (final k in keyValueLists) {
      if (k.key == key && k.val == val && k.valType == valType(val)) {
        flag = false;
        break;
      } else if (k.key == key) {
        k.val = val;
        k.valType = valType(val);
        flag = false;
        break;
      }
    }
    if (flag) {
      keyValueLists.add(
          db.KeyValueObjectBuilder(key: key, val: val, valType: valType(val)));
    }
    _flush();
  }

  static Future<void> remove(String key) async {
    keyValueLists.removeWhere((item) => item.key == key);
    _flush();
  }


   static void _flush() {
    scheduleMicrotask(() {
      final originalBytes = db.KeyValueListObjectBuilder(lists: keyValueLists).toBytes();
      if (originalBytes.isNotEmpty) {
        _file.writeAsBytes(
            _encrypter.encryptBytes(originalBytes, iv: _iv).bytes,
            flush: true);
      }
    });
  }

  static void clearAll() {
    scheduleMicrotask(() async {
      if (await _file.exists()) {
        await _file.delete();
      }
    });
  }

}
