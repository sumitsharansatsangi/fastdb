library;

import 'dart:async';
import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:path_provider/path_provider.dart';
import 'fastdb_generated.dart' as db;

class FastDB {
  static final FastDB _instance = FastDB._internal();
  factory FastDB() => _instance;
  FastDB._internal();
  static late final encrypt.Key _key;
  static late final encrypt.IV _iv;
  static const _ssKey = 'ss';
  static const _svKey = 'sv';
  static const _keyLength = 32;
  static const _ivLength = 16;

  static List<db.KeyValueObjectBuilder> keyValueLists = [];
  static late File _file;
  static late encrypt.Encrypter _encrypter;

  static Future<void> init() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage(
        aOptions: AndroidOptions(
            encryptedSharedPreferences: true, resetOnError: true));
    await _initializeKeys(secureStorage);
    _encrypter =
        encrypt.Encrypter(encrypt.AES(_key, mode: encrypt.AESMode.cbc));
    final directory = await getApplicationSupportDirectory();
    _file = File('${directory.path}/fastDB.dat');
    if (await _file.exists()) {
      await _decryptFile();
    } else {
      await _file.create(recursive: true);
    }
  }

  static Future<void> _initializeKeys(
      FlutterSecureStorage secureStorage) async {
    final encryptedSSData = await secureStorage.read(key: _ssKey);
    final encryptedSVData = await secureStorage.read(key: _svKey);
    if (encryptedSSData == null) {
      _key = encrypt.Key.fromLength(_keyLength);
      await secureStorage.write(key: _ssKey, value: _key.base64);
    } else {
      _key = encrypt.Key.fromBase64(encryptedSSData);
    }
    if (encryptedSVData == null) {
      _iv = encrypt.IV.fromLength(_ivLength);
      await secureStorage.write(key: _svKey, value: _iv.base64);
    } else {
      _iv = encrypt.IV.fromBase64(encryptedSVData);
    }
  }

  static Future<void> _decryptFile() async {
    try {
      final bytes = Inflate(await _file.readAsBytes()).getBytes();
      if (bytes.isNotEmpty) {
        final decrypted = _encrypter.decryptBytes(
            encrypt.Encrypted(Uint8List.fromList(bytes)),
            iv: _iv);
        db.KeyValueList fastDB = db.KeyValueList(decrypted);
        for (var l in fastDB.lists!) {
          var valType = parseVal(l.val.val);
          keyValueLists.add(db.KeyValueObjectBuilder(
              key: l.key!,
              val: valType.wrapperObjectBuilder,
              valType: valType.typeId));
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static ValType parseVal(Object val) {
    if (val is String) {
      return ValType(
          db.AnyTypeId.StringWrapper, db.StringWrapperObjectBuilder(val: val));
    } else if (val is int && val >= 0 && val <= 255) {
      return ValType(db.AnyTypeId.PositiveByteWrapper,
          db.PositiveByteWrapperObjectBuilder(val: val));
    } else if (val is int && val >= -128 && val <= 127) {
      return ValType(
          db.AnyTypeId.ByteWrapper, db.ByteWrapperObjectBuilder(val: val));
    } else if (val is int && val >= 0 && val <= 65535) {
      return ValType(db.AnyTypeId.PositiveShortWrapper,
          db.PositiveShortWrapperObjectBuilder(val: val));
    } else if (val is int && val >= -32768 && val <= 32767) {
      return ValType(
          db.AnyTypeId.ShortWrapper, db.ShortWrapperObjectBuilder(val: val));
    } else if (val is int && val >= 0 && val <= 4294967295) {
      return ValType(
          db.AnyTypeId.PositiveIntWrapper, db.PositiveIntWrapperObjectBuilder(val: val));
    } else if (val is int && val >= -2147483648 && val <= 2147483647) {
      return ValType(
          db.AnyTypeId.IntWrapper, db.IntWrapperObjectBuilder(val: val));
    } else if (val is int &&
        val >= 0 &&
        val <=9223372036854775807) {
      return ValType(
          db.AnyTypeId.PositiveLongWrapper, db.PositiveLongWrapperObjectBuilder(val: val));
    } else if (val is int &&
        val >= -9223372036854775808 &&
        val <= 9223372036854775807) {
      return ValType(
          db.AnyTypeId.LongWrapper, db.LongWrapperObjectBuilder(val: val));
    } else if (val is double && val >= -3.4028235e+38 && val <= 3.4028235e+38) {
      return ValType(
          db.AnyTypeId.FloatWrapper, db.FloatWrapperObjectBuilder(val: val));
    } else if (val is double &&
        val >= -1.7976931348623157e+308 &&
        val <= 1.7976931348623157e+308) {
      return ValType(
          db.AnyTypeId.DoubleWrapper, db.DoubleWrapperObjectBuilder(val: val));
    } else if (val is bool) {
      return ValType(
          db.AnyTypeId.BoolWrapper, db.BoolWrapperObjectBuilder(val: val));
    } else if (val is List<String>) {
      return ValType(
          db.AnyTypeId.ListString, db.ListStringObjectBuilder(val: val));
    } else if (val is List<int> &&
        val.every((value) => value >= 0 && value <= 255)) {
      return ValType(db.AnyTypeId.ListPositiveByte, db.ListPositiveByteObjectBuilder(val: val));
    } 
    else if (val is List<int> &&
        val.every((value) => value >= -128 && value <= 127)) {
      return ValType(db.AnyTypeId.ListByte, db.ListByteObjectBuilder(val: val));
    } else if (val is List<int> &&
        val.every((value) => value >= 0 && value <= 65535)) {
      return ValType(
          db.AnyTypeId.ListPositiveShort, db.ListPositiveShortObjectBuilder(val: val));
    } else if (val is List<int> &&
        val.every((value) => value >= -32768 && value <= 32767)) {
      return ValType(
          db.AnyTypeId.ListShort, db.ListShortObjectBuilder(val: val));
    }else if (val is List<int> &&
        val.every((value) => value >= 0 && value <= 4294967295)) {
      return ValType(db.AnyTypeId.ListPositiveInt, db.ListPositiveIntObjectBuilder(val: val));
    }
     else if (val is List<int> &&
        val.every((value) => value >= -2147483648 && value <= 2147483647)) {
      return ValType(db.AnyTypeId.ListInt, db.ListIntObjectBuilder(val: val));
    } else if (val is List<int> &&
        val.every((value) =>
            value >= 0 && value <= 9223372036854775807)) {
      return ValType(db.AnyTypeId.ListPositiveLong, db.ListPositiveLongObjectBuilder(val: val));
    }
     else if (val is List<int> &&
        val.every((value) =>
            value >= -9223372036854775808 && value <= 9223372036854775807)) {
      return ValType(db.AnyTypeId.ListLong, db.ListLongObjectBuilder(val: val));
    } else if (val is List<double> &&
        val.every(
          (value) => value >= -3.4028235e+38 && value <= 3.4028235e+38,
        )) {
      return ValType(
          db.AnyTypeId.ListFloat, db.ListFloatObjectBuilder(val: val));
    } else if (val is List<double> &&
        val.every((value) =>
            value >= -1.7976931348623157e+308 &&
            value <= 1.7976931348623157e+308)) {
      return ValType(
          db.AnyTypeId.ListDouble, db.ListDoubleObjectBuilder(val: val));
    } else if (val is List<bool>) {
      return ValType(db.AnyTypeId.ListBool, db.ListBoolObjectBuilder(val: val));
    } else if (val is db.ComplexObject) {
      return ValType(
          db.AnyTypeId.ComplexObject,
          db.ComplexObjectObjectBuilder(
              name: val.name,
              age: val.age,
              salary: val.salary,
              isActive: val.isActive));
    } else {
      throw ArgumentError('Unsupported value type');
    }
  }

  static String? getString(String key) {
    for (final k in keyValueLists) {
      if (k.key == key) {
        return db.StringWrapper(k.val.toBytes()).val;
      }
    }
    return null;
  }

  static List<String>? getListString(String key) {
    for (final k in keyValueLists) {
      if (k.key == key) {
        return db.ListString(k.val.toBytes()).val;
      }
    }
    return null;
  }

  static int? getInt(String key) {
    for (final k in keyValueLists) {
      if (k.key == key) {
        return db.IntWrapper(k.val.toBytes()).val;
      }
    }
    return null;
  }

  static List<int>? getListInt(String key) {
    for (final k in keyValueLists) {
      if (k.key == key) {
        return db.ListInt(k.val.toBytes()).val;
      }
    }
    return null;
  }

  static int? getPositiveInt(String key) {
    for (final k in keyValueLists) {
      if (k.key == key) {
        return db.PositiveIntWrapper(k.val.toBytes()).val;
      }
    }
    return null;
  }

  static List<int>? getPositiveListInt(String key) {
    for (final k in keyValueLists) {
      if (k.key == key) {
        return db.ListPositiveInt(k.val.toBytes()).val;
      }
    }
    return null;
  }

  static int? getByte(String key) {
    for (final k in keyValueLists) {
      if (k.key == key) {
        return db.ByteWrapper(k.val.toBytes()).val;
      }
    }
    return null;
  }

  static List<int>? getListByte(String key) {
    for (final k in keyValueLists) {
      if (k.key == key) {
        return db.ListByte(k.val.toBytes()).val;
      }
    }
    return null;
  }

  static int? getPositiveByte(String key) {
    for (final k in keyValueLists) {
      if (k.key == key) {
        return db.PositiveByteWrapper(k.val.toBytes()).val;
      }
    }
    return null;
  }

  static List<int>? getPositiveListByte(String key) {
    for (final k in keyValueLists) {
      if (k.key == key) {
        return db.ListPositiveByte(k.val.toBytes()).val;
      }
    }
    return null;
  }

  static int? getShort(String key) {
    for (final k in keyValueLists) {
      if (k.key == key) {
        return db.ShortWrapper(k.val.toBytes()).val;
      }
    }
    return null;
  }

  static List<int>? getListShort(String key) {
    for (final k in keyValueLists) {
      if (k.key == key) {
        return db.ListShort(k.val.toBytes()).val;
      }
    }
    return null;
  }

   static int? getPositiveShort(String key) {
    for (final k in keyValueLists) {
      if (k.key == key) {
        return db.PositiveShortWrapper(k.val.toBytes()).val;
      }
    }
    return null;
  }

  static List<int>? getPositiveListShort(String key) {
    for (final k in keyValueLists) {
      if (k.key == key) {
        return db.ListPositiveShort(k.val.toBytes()).val;
      }
    }
    return null;
  }


  static int? getLong(String key) {
    for (final k in keyValueLists) {
      if (k.key == key) {
        return db.LongWrapper(k.val.toBytes()).val;
      }
    }
    return null;
  }

  static List<int>? getListLong(String key) {
    for (final k in keyValueLists) {
      if (k.key == key) {
        return db.ListLong(k.val.toBytes()).val;
      }
    }
    return null;
  }

   static int? getPositiveLong(String key) {
    for (final k in keyValueLists) {
      if (k.key == key) {
        return db.PositiveLongWrapper(k.val.toBytes()).val;
      }
    }
    return null;
  }

  static List<int>? getPositiveListLong(String key) {
    for (final k in keyValueLists) {
      if (k.key == key) {
        return db.ListPositiveLong(k.val.toBytes()).val;
      }
    }
    return null;
  }


  static double? getFloat(String key) {
    for (final k in keyValueLists) {
      if (k.key == key) {
        return db.FloatWrapper(k.val.toBytes()).val;
      }
    }
    return null;
  }

  static List<double>? getListFloat(String key) {
    for (final k in keyValueLists) {
      if (k.key == key) {
        return db.ListFloat(k.val.toBytes()).val;
      }
    }
    return null;
  }

  static double? getDouble(String key) {
    for (final k in keyValueLists) {
      if (k.key == key) {
        return db.DoubleWrapper(k.val.toBytes()).val;
      }
    }
    return null;
  }

  static List<double>? getListDouble(String key) {
    for (final k in keyValueLists) {
      if (k.key == key) {
        return db.ListDouble(k.val.toBytes()).val;
      }
    }
    return null;
  }

  static bool? getBool(String key) {
    for (final k in keyValueLists) {
      if (k.key == key) {
        return db.BoolWrapper(k.val.toBytes()).val;
      }
    }
    return null;
  }

  static List<bool>? getListBool(String key) {
    for (final k in keyValueLists) {
      if (k.key == key) {
        return db.ListBool(k.val.toBytes()).val;
      }
    }
    return null;
  }

  static void putString(String key, String val) {
    bool flag = true;
    for (final k in keyValueLists) {
      if (k.key == key) {
        k.val = db.StringWrapperObjectBuilder(val: val);
        k.valType = db.AnyTypeId.StringWrapper;
        flag = false;
        break;
      }
    }
    if (flag) {
      keyValueLists.add(db.KeyValueObjectBuilder(
          key: key,
          val: db.StringWrapperObjectBuilder(val: val),
          valType: db.AnyTypeId.StringWrapper));
    }
  }

  static void putListString(String key, List<String> val) {
    bool flag = true;
    for (final k in keyValueLists) {
      if (k.key == key) {
        k.val = db.ListStringObjectBuilder(val: val);
        k.valType = db.AnyTypeId.ListString;
        flag = false;
        break;
      }
    }
    if (flag) {
      keyValueLists.add(db.KeyValueObjectBuilder(
          key: key,
          val: db.ListStringObjectBuilder(val: val),
          valType: db.AnyTypeId.ListString));
    }
  }

  static void putInt(String key, int val){
    bool flag = true;
    for (final k in keyValueLists) {
      if (k.key == key) {
        k.val = db.IntWrapperObjectBuilder(val: val);
        k.valType = db.AnyTypeId.IntWrapper;
        flag = false;
        break;
      }
    }
    if (flag) {
      keyValueLists.add(db.KeyValueObjectBuilder(
          key: key,
          val: db.IntWrapperObjectBuilder(val: val),
          valType: db.AnyTypeId.IntWrapper));
    }
  }

  static void putListInt(String key, List<int> val){
    bool flag = true;
    for (final k in keyValueLists) {
      if (k.key == key) {
        k.val = db.ListIntObjectBuilder(val: val);
        k.valType = db.AnyTypeId.ListInt;
        flag = false;
        break;
      }
    }
    if (flag) {
      keyValueLists.add(db.KeyValueObjectBuilder(
          key: key,
          val: db.ListIntObjectBuilder(val: val),
          valType: db.AnyTypeId.ListInt));
    }
  }

   static void putPositiveInt(String key, int val){
    bool flag = true;
    for (final k in keyValueLists) {
      if (k.key == key) {
        k.val = db.PositiveIntWrapperObjectBuilder(val: val);
        k.valType = db.AnyTypeId.PositiveIntWrapper;
        flag = false;
        break;
      }
    }
    if (flag) {
      keyValueLists.add(db.KeyValueObjectBuilder(
          key: key,
          val: db.PositiveIntWrapperObjectBuilder(val: val),
          valType: db.AnyTypeId.PositiveIntWrapper));
    }
  }

  static void putPositiveListInt(String key, List<int> val) {
    bool flag = true;
    for (final k in keyValueLists) {
      if (k.key == key) {
        k.val = db.ListPositiveIntObjectBuilder(val: val);
        k.valType = db.AnyTypeId.ListPositiveInt;
        flag = false;
        break;
      }
    }
    if (flag) {
      keyValueLists.add(db.KeyValueObjectBuilder(
          key: key,
          val: db.ListPositiveIntObjectBuilder(val: val),
          valType: db.AnyTypeId.ListPositiveInt));
    }
  }


  static void putByte(String key, int val) {
    bool flag = true;
    for (final k in keyValueLists) {
      if (k.key == key) {
        k.val = db.ByteWrapperObjectBuilder(val: val);
        k.valType = db.AnyTypeId.ByteWrapper;
        flag = false;
        break;
      }
    }
    if (flag) {
      keyValueLists.add(db.KeyValueObjectBuilder(
          key: key,
          val: db.ByteWrapperObjectBuilder(val: val),
          valType: db.AnyTypeId.ByteWrapper));
    }
  }

  static void putListByte(String key, List<int> val) {
    bool flag = true;
    for (final k in keyValueLists) {
      if (k.key == key) {
        k.val = db.ListByteObjectBuilder(val: val);
        k.valType = db.AnyTypeId.ListByte;
        flag = false;
        break;
      }
    }
    if (flag) {
      keyValueLists.add(db.KeyValueObjectBuilder(
          key: key,
          val: db.ListByteObjectBuilder(val: val),
          valType: db.AnyTypeId.ListByte));
    }
  }

   static void putPositiveByte(String key, int val){
    bool flag = true;
    for (final k in keyValueLists) {
      if (k.key == key) {
        k.val = db.PositiveByteWrapperObjectBuilder(val: val);
        k.valType = db.AnyTypeId.PositiveByteWrapper;
        flag = false;
        break;
      }
    }
    if (flag) {
      keyValueLists.add(db.KeyValueObjectBuilder(
          key: key,
          val: db.PositiveByteWrapperObjectBuilder(val: val),
          valType: db.AnyTypeId.PositiveByteWrapper));
    }
  }

  static void putPositiveListByte(String key, List<int> val){
    bool flag = true;
    for (final k in keyValueLists) {
      if (k.key == key) {
        k.val = db.ListPositiveByteObjectBuilder(val: val);
        k.valType = db.AnyTypeId.ListPositiveByte;
        flag = false;
        break;
      }
    }
    if (flag) {
      keyValueLists.add(db.KeyValueObjectBuilder(
          key: key,
          val: db.ListPositiveByteObjectBuilder(val: val),
          valType: db.AnyTypeId.ListPositiveByte));
    }
  }


  static void putShort(String key, int val){
    bool flag = true;
    for (final k in keyValueLists) {
      if (k.key == key) {
        k.val = db.ShortWrapperObjectBuilder(val: val);
        k.valType = db.AnyTypeId.ShortWrapper;
        flag = false;
        break;
      }
    }
    if (flag) {
      keyValueLists.add(db.KeyValueObjectBuilder(
          key: key,
          val: db.ShortWrapperObjectBuilder(val: val),
          valType: db.AnyTypeId.ShortWrapper));
    }
  }

  static void putListShort(String key, List<int> val){
    bool flag = true;
    for (final k in keyValueLists) {
      if (k.key == key) {
        k.val = db.ListShortObjectBuilder(val: val);
        k.valType = db.AnyTypeId.ListShort;
        flag = false;
        break;
      }
    }
    if (flag) {
      keyValueLists.add(db.KeyValueObjectBuilder(
          key: key,
          val: db.ListShortObjectBuilder(val: val),
          valType: db.AnyTypeId.ListShort));
    }
  }

   static void putPositiveShort(String key, int val){
    bool flag = true;
    for (final k in keyValueLists) {
      if (k.key == key) {
        k.val = db.PositiveShortWrapperObjectBuilder(val: val);
        k.valType = db.AnyTypeId.PositiveShortWrapper;
        flag = false;
        break;
      }
    }
    if (flag) {
      keyValueLists.add(db.KeyValueObjectBuilder(
          key: key,
          val: db.PositiveShortWrapperObjectBuilder(val: val),
          valType: db.AnyTypeId.PositiveShortWrapper));
    }
  }

  static void putPositiveListShort(String key, List<int> val) {
    bool flag = true;
    for (final k in keyValueLists) {
      if (k.key == key) {
        k.val = db.ListPositiveShortObjectBuilder(val: val);
        k.valType = db.AnyTypeId.ListPositiveShort;
        flag = false;
        break;
      }
    }
    if (flag) {
      keyValueLists.add(db.KeyValueObjectBuilder(
          key: key,
          val: db.ListPositiveShortObjectBuilder(val: val),
          valType: db.AnyTypeId.ListPositiveShort));
    }
  }

 static void putLong(String key, int val){
    bool flag = true;
    for (final k in keyValueLists) {
      if (k.key == key) {
        k.val = db.LongWrapperObjectBuilder(val: val);
        k.valType = db.AnyTypeId.LongWrapper;
        flag = false;
        break;
      }
    }
    if (flag) {
      keyValueLists.add(db.KeyValueObjectBuilder(
          key: key,
          val: db.LongWrapperObjectBuilder(val: val),
          valType: db.AnyTypeId.LongWrapper));
    }
  }

  static void putListLong(String key, List<int> val){
    bool flag = true;
    for (final k in keyValueLists) {
      if (k.key == key) {
        k.val = db.ListLongObjectBuilder(val: val);
        k.valType = db.AnyTypeId.ListLong;
        flag = false;
        break;
      }
    }
    if (flag) {
      keyValueLists.add(db.KeyValueObjectBuilder(
          key: key,
          val: db.ListLongObjectBuilder(val: val),
          valType: db.AnyTypeId.ListLong));
    }
  }

   static void putPositiveLong(String key, int val){
    bool flag = true;
    for (final k in keyValueLists) {
      if (k.key == key) {
        k.val = db.PositiveLongWrapperObjectBuilder(val: val);
        k.valType = db.AnyTypeId.PositiveLongWrapper;
        flag = false;
        break;
      }
    }
    if (flag) {
      keyValueLists.add(db.KeyValueObjectBuilder(
          key: key,
          val: db.PositiveLongWrapperObjectBuilder(val: val),
          valType: db.AnyTypeId.PositiveLongWrapper));
    }
  }

  static void putPositiveListLong(String key, List<int> val){
    bool flag = true;
    for (final k in keyValueLists) {
      if (k.key == key) {
        k.val = db.ListPositiveLongObjectBuilder(val: val);
        k.valType = db.AnyTypeId.ListPositiveLong;
        flag = false;
        break;
      }
    }
    if (flag) {
      keyValueLists.add(db.KeyValueObjectBuilder(
          key: key,
          val: db.ListPositiveLongObjectBuilder(val: val),
          valType: db.AnyTypeId.ListPositiveLong));
    }
  }



  static void putDouble(String key, double val){
    bool flag = true;
    for (final k in keyValueLists) {
      if (k.key == key) {
        k.val = db.DoubleWrapperObjectBuilder(val: val);
        k.valType = db.AnyTypeId.DoubleWrapper;
        flag = false;
        break;
      }
    }
    if (flag) {
      keyValueLists.add(db.KeyValueObjectBuilder(
          key: key,
          val: db.DoubleWrapperObjectBuilder(val: val),
          valType: db.AnyTypeId.DoubleWrapper));
    }
  }

  static void putListDouble(String key, List<double> val){
    bool flag = true;
    for (final k in keyValueLists) {
      if (k.key == key) {
        k.val = db.ListDoubleObjectBuilder(val: val);
        k.valType = db.AnyTypeId.ListDouble;
        flag = false;
        break;
      }
    }
    if (flag) {
      keyValueLists.add(db.KeyValueObjectBuilder(
          key: key,
          val: db.ListDoubleObjectBuilder(val: val),
          valType: db.AnyTypeId.ListDouble));
    }
  }

  static void putFloat(String key, double val){
    bool flag = true;
    for (final k in keyValueLists) {
      if (k.key == key) {
        k.val = db.FloatWrapperObjectBuilder(val: val);
        k.valType = db.AnyTypeId.FloatWrapper;
        flag = false;
        break;
      }
    }
    if (flag) {
      keyValueLists.add(db.KeyValueObjectBuilder(
          key: key,
          val: db.FloatWrapperObjectBuilder(val: val),
          valType: db.AnyTypeId.FloatWrapper));
    }
  }

  static void putListFloat(String key, List<double> val) {
    bool flag = true;
    for (final k in keyValueLists) {
      if (k.key == key) {
        k.val = db.ListFloatObjectBuilder(val: val);
        k.valType = db.AnyTypeId.ListFloat;
        flag = false;
        break;
      }
    }
    if (flag) {
      keyValueLists.add(db.KeyValueObjectBuilder(
          key: key,
          val: db.ListFloatObjectBuilder(val: val),
          valType: db.AnyTypeId.ListFloat));
    }
  }

  static void putBool(String key, bool val){
    bool flag = true;
    for (final k in keyValueLists) {
      if (k.key == key) {
        k.val = db.BoolWrapperObjectBuilder(val: val);
        k.valType = db.AnyTypeId.BoolWrapper;
        flag = false;
        break;
      }
    }
    if (flag) {
      keyValueLists.add(db.KeyValueObjectBuilder(
          key: key,
          val: db.BoolWrapperObjectBuilder(val: val),
          valType: db.AnyTypeId.BoolWrapper));
    }
  }

  static void putListBool(String key, List<bool> val){
    bool flag = true;
    for (final k in keyValueLists) {
      if (k.key == key) {
        k.val = db.ListBoolObjectBuilder(val: val);
        k.valType = db.AnyTypeId.ListBool;
        flag = false;
        break;
      }
    }
    if (flag) {
      keyValueLists.add(db.KeyValueObjectBuilder(
          key: key,
          val: db.ListBoolObjectBuilder(val: val),
          valType: db.AnyTypeId.ListBool));
    }
  }

  static void remove(String key) {
    keyValueLists.removeWhere((item) => item.key == key);
  }

  static void flush() {
    scheduleMicrotask(() {
      final originalBytes =
          db.KeyValueListObjectBuilder(lists: keyValueLists).toBytes();
      if (originalBytes.isNotEmpty) {
        _file.writeAsBytes(
            Deflate(_encrypter.encryptBytes(originalBytes, iv: _iv).bytes)
                .getBytes(),
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

class ValType {
  db.AnyTypeId typeId;
  db.WrapperObjectBuilder wrapperObjectBuilder;

  ValType(this.typeId, this.wrapperObjectBuilder);
}
