library;

import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'fastdb_generated.dart' as db;

class FastDB {
  static final FastDB _instance = FastDB._internal();
  factory FastDB() => _instance;
  FastDB._internal();

  static List<db.KeyValueObjectBuilder> keyValueLists = [];
  static late File _file;

  static Future<void> init() async {
    final directory = await getApplicationSupportDirectory();
    _file = File('${directory.path}/fastDB.dat');
    if (await _file.exists()) {
      await _decryptFile();
    } else {
      await _file.create(recursive: true);
    }
  }

  static Future<void> _decryptFile() async {
    try {
      final bytes = await _file.readAsBytes();
      if (bytes.isNotEmpty) {
        db.KeyValueList fastDB = db.KeyValueList(bytes);
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
      return ValType(db.AnyTypeId.StringWrapper, db.StringWrapperObjectBuilder(val: val));
    }else if (val is int && val >= -128 && val <= 127) {
      return ValType(db.AnyTypeId.ByteWrapper, db.ByteWrapperObjectBuilder(val: val));
    }else if (val is int && val >= -32768 && val <= 32767) {
      return ValType(db.AnyTypeId.ShortWrapper, db.ShortWrapperObjectBuilder(val: val));
    }else if (val is int && val >= -2147483648 && val <= 2147483647) {
      return ValType(db.AnyTypeId.IntWrapper, db.IntWrapperObjectBuilder(val: val));
    }else if (val is int && val >= -9223372036854775808 && val <= 9223372036854775807){
      return ValType(db.AnyTypeId.LongWrapper, db.LongWrapperObjectBuilder(val: val));
    }else if (val is double && val >= -3.4028235e+38 && val <= 3.4028235e+38) {
      return ValType(db.AnyTypeId.FloatWrapper ,db.FloatWrapperObjectBuilder(val: val));
    }else if (val is double &&   val >= -1.7976931348623157e+308 && val <= 1.7976931348623157e+308) {
      return ValType(db.AnyTypeId.DoubleWrapper, db.DoubleWrapperObjectBuilder(val: val));
    } else if (val is bool) {
      return ValType(db.AnyTypeId.BoolWrapper, db.BoolWrapperObjectBuilder(val: val));
    } else if (val is List<String>) {
      return ValType(db.AnyTypeId.ListString, db.ListStringObjectBuilder(val: val));
    } else if (val is List<int> && val.every((value) => value >= -128 && value <= 127)) {
      return ValType(db.AnyTypeId.ListByte, db.ListByteObjectBuilder(val: val));
    } else if (val is List<int> && val.every((value) => value >= -32768 && value <= 32767)) {
      return ValType(db.AnyTypeId.ListShort, db.ListShortObjectBuilder(val: val));
    } else if (val is List<int> && val.every((value) => value >= -2147483648 && value <= 2147483647)) {
      return ValType(db.AnyTypeId.ListInt, db.ListIntObjectBuilder(val: val));
    } else if (val is List<int> && val.every((value) => value >= -9223372036854775808 && value <= 9223372036854775807)) {
      return ValType(db.AnyTypeId.ListLong, db.ListLongObjectBuilder(val: val));
    } else if (val is List<double> &&  val.every((value) => value >= -3.4028235e+38&& value <= 3.4028235e+38,) ) {
      return ValType(db.AnyTypeId.ListFloat, db.ListFloatObjectBuilder(val: val));
    } else if (val is List<double> && val.every((value) => value >= -1.7976931348623157e+308 && value <= 1.7976931348623157e+308)) {
      return ValType(db.AnyTypeId.ListDouble, db.ListDoubleObjectBuilder(val: val));
    } else if (val is List<bool>) {
      return ValType(db.AnyTypeId.ListBool, db.ListBoolObjectBuilder(val: val));
    } else if (val is db.ComplexObject) {
      return ValType(db.AnyTypeId.ComplexObject, db.ComplexObjectObjectBuilder(
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

  static Future<void> putString(String key, String val) async {
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

  static Future<void> putListString(String key, List<String> val) async {
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

  static Future<void> putInt(String key, int val) async {
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

  static Future<void> putListInt(String key, List<int> val) async {
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

   static Future<void> putByte(String key, int val) async {
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

  static Future<void> putListByte(String key, List<int> val) async {
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

  static Future<void> putShort(String key, int val) async {
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

  static Future<void> putListShort(String key, List<int> val) async {
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

  static Future<void> putDouble(String key, double val) async {
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

  static Future<void> putListDouble(String key, List<double> val) async {
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

  static Future<void> putFloat(String key, double val) async {
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

  static Future<void> putListFloat(String key, List<double> val) async {
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

  static Future<void> putBool(String key, bool val) async {
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

  static Future<void> putListBool(String key, List<bool> val) async {
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

  static Future<void> remove(String key) async {
    keyValueLists.removeWhere((item) => item.key == key);
  }

  static void flush() {
    scheduleMicrotask(() {
      final originalBytes =
          db.KeyValueListObjectBuilder(lists: keyValueLists).toBytes();
      if (originalBytes.isNotEmpty) {
        _file.writeAsBytes(originalBytes, flush: true);
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


class ValType{
  db.AnyTypeId typeId;
  db.WrapperObjectBuilder wrapperObjectBuilder; 

  ValType(this.typeId, this.wrapperObjectBuilder);
}