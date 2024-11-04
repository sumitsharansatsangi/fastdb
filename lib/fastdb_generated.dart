// automatically generated by the FlatBuffers compiler, do not modify
// ignore_for_file: unused_import, unused_field, unused_element, unused_local_variable

import 'dart:typed_data' show Uint8List;
import 'flat_buffers.dart' as fb;

class AnyTypeId {
  final int value;
  const AnyTypeId._(this.value);

  factory AnyTypeId.fromValue(int value) {
    final result = values[value];
    if (result == null) {
      throw StateError('Invalid value $value for bit flag enum AnyTypeId');
    }
    return result;
  }

  static AnyTypeId? _createOrNull(int? value) =>
      value == null ? null : AnyTypeId.fromValue(value);

  static const int minValue = 0;
  static const int maxValue = 17;
  static bool containsValue(int value) => values.containsKey(value);

  static const AnyTypeId NONE = AnyTypeId._(0);
  static const AnyTypeId ListString = AnyTypeId._(1);
  static const AnyTypeId ListInt = AnyTypeId._(2);
  static const AnyTypeId ListShort = AnyTypeId._(3);
  static const AnyTypeId ListLong = AnyTypeId._(4);
  static const AnyTypeId ListFloat = AnyTypeId._(5);
  static const AnyTypeId ListDouble = AnyTypeId._(6);
  static const AnyTypeId ListBool = AnyTypeId._(7);
  static const AnyTypeId ListByte = AnyTypeId._(8);
  static const AnyTypeId ComplexObject = AnyTypeId._(9);
  static const AnyTypeId IntWrapper = AnyTypeId._(10);
  static const AnyTypeId DoubleWrapper = AnyTypeId._(11);
  static const AnyTypeId BoolWrapper = AnyTypeId._(12);
  static const AnyTypeId StringWrapper = AnyTypeId._(13);
  static const AnyTypeId ByteWrapper = AnyTypeId._(14);
  static const AnyTypeId LongWrapper = AnyTypeId._(15);
  static const AnyTypeId ShortWrapper = AnyTypeId._(16);
  static const AnyTypeId FloatWrapper = AnyTypeId._(17);
  static const Map<int, AnyTypeId> values = {
    0: NONE,
    1: ListString,
    2: ListInt,
    3: ListShort,
    4: ListLong,
    5: ListFloat,
    6: ListDouble,
    7: ListBool,
    8: ListByte,
    9: ComplexObject,
    10: IntWrapper,
    11: DoubleWrapper,
    12: BoolWrapper,
    13: StringWrapper,
    14: ByteWrapper,
    15: LongWrapper,
    16: ShortWrapper,
    17: FloatWrapper};


  static const fb.Reader<AnyTypeId> reader = _AnyTypeIdReader();

  @override
  String toString() {
    return 'AnyTypeId{value: $value}';
  }
}

class _AnyTypeIdReader extends fb.Reader<AnyTypeId> {
  const _AnyTypeIdReader();

  @override
  int get size => 1;

  @override
  AnyTypeId read(fb.BufferContext bc, int offset) =>
      AnyTypeId.fromValue(const fb.Uint8Reader().read(bc, offset));
}

abstract class WrapperObjectBuilder extends fb.ObjectBuilder {}

class ListString {
  ListString._(this._bc, this._bcOffset);
  factory ListString(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<ListString> reader = _ListStringReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  List<String>? get val => const fb.ListReader<String>(fb.StringReader())
      .vTableGetNullable(_bc, _bcOffset, 4);

  @override
  String toString() {
    return 'ListString{val: $val}';
  }
}

class _ListStringReader extends fb.TableReader<ListString> {
  const _ListStringReader();

  @override
  ListString createObject(fb.BufferContext bc, int offset) =>
      ListString._(bc, offset);
}

class ListStringObjectBuilder extends WrapperObjectBuilder {
  final List<String>? _val;

  ListStringObjectBuilder({
    List<String>? val,
  }) : _val = val;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    final int? valOffset = _val == null
        ? null
        : fbBuilder.writeList(_val.map(fbBuilder.writeString).toList());
    fbBuilder.startTable(1);
    fbBuilder.addOffset(0, valOffset);
    return fbBuilder.endTable();
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String? fileIdentifier]) {
    final fbBuilder = fb.Builder(deduplicateTables: false);
    fbBuilder.finish(finish(fbBuilder), fileIdentifier);
    return fbBuilder.buffer;
  }
}

class ListInt {
  ListInt._(this._bc, this._bcOffset);
  factory ListInt(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<ListInt> reader = _ListIntReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  List<int>? get val => const fb.ListReader<int>(fb.Int32Reader())
      .vTableGetNullable(_bc, _bcOffset, 4);

  @override
  String toString() {
    return 'ListInt{val: $val}';
  }
}

class _ListIntReader extends fb.TableReader<ListInt> {
  const _ListIntReader();

  @override
  ListInt createObject(fb.BufferContext bc, int offset) =>
      ListInt._(bc, offset);
}

class ListIntObjectBuilder extends WrapperObjectBuilder {
  final List<int> _val;

  ListIntObjectBuilder({
   required List<int> val,
  }) : assert(val.every((value) => value >= -2147483648 && value <= 2147483647),"Not a valid list of int value"), _val = val;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    final int valOffset = fbBuilder.writeListInt32(_val);
    fbBuilder.startTable(1);
    fbBuilder.addOffset(0, valOffset);
    return fbBuilder.endTable();
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String? fileIdentifier]) {
    final fbBuilder = fb.Builder(deduplicateTables: false);
    fbBuilder.finish(finish(fbBuilder), fileIdentifier);
    return fbBuilder.buffer;
  }
}

class ListByte {
  ListByte._(this._bc, this._bcOffset);
  factory ListByte(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<ListByte> reader = _ListByteReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  List<int>? get val => const fb.Int8ListReader().vTableGetNullable(_bc, _bcOffset, 4);

  @override
  String toString() {
    return 'ListByte{val: $val}';
  }
}

class _ListByteReader extends fb.TableReader<ListByte> {
  const _ListByteReader();

  @override
  ListByte createObject(fb.BufferContext bc, int offset) => 
    ListByte._(bc, offset);
}

class ListByteBuilder {
  ListByteBuilder(this.fbBuilder);

  final fb.Builder fbBuilder;

  void begin() {
    fbBuilder.startTable(1);
  }

  int addValOffset(int? offset) {
    fbBuilder.addOffset(0, offset);
    return fbBuilder.offset;
  }

  int finish() {
    return fbBuilder.endTable();
  }
}

class ListByteObjectBuilder extends WrapperObjectBuilder {
  final List<int> _val;

  ListByteObjectBuilder({
   required List<int> val,
  })
      : assert(val.every((value) => value >= -128 && value <= 127),"Not a vlaid list of bytes"), _val = val;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    final int valOffset = fbBuilder.writeListInt8(_val);
    fbBuilder.startTable(1);
    fbBuilder.addOffset(0, valOffset);
    return fbBuilder.endTable();
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String? fileIdentifier]) {
    final fbBuilder = fb.Builder(deduplicateTables: false);
    fbBuilder.finish(finish(fbBuilder), fileIdentifier);
    return fbBuilder.buffer;
  }
}

class ListShort {
  ListShort._(this._bc, this._bcOffset);
  factory ListShort(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<ListShort> reader = _ListShortReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  List<int>? get val => const fb.ListReader<int>(fb.Int16Reader())
      .vTableGetNullable(_bc, _bcOffset, 4);

  @override
  String toString() {
    return 'ListShort{val: $val}';
  }
}

class _ListShortReader extends fb.TableReader<ListShort> {
  const _ListShortReader();

  @override
  ListShort createObject(fb.BufferContext bc, int offset) =>
      ListShort._(bc, offset);
}

class ListShortObjectBuilder extends WrapperObjectBuilder {
  final List<int> _val;

  ListShortObjectBuilder({
   required List<int> val,
  }) : assert(val.every((value) => value >= -32768 && value <= 32767), "Not a valid list of Short Value"), _val = val;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    final int valOffset = fbBuilder.writeListInt16(_val);
    fbBuilder.startTable(1);
    fbBuilder.addOffset(0, valOffset);
    return fbBuilder.endTable();
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String? fileIdentifier]) {
    final fbBuilder = fb.Builder(deduplicateTables: false);
    fbBuilder.finish(finish(fbBuilder), fileIdentifier);
    return fbBuilder.buffer;
  }
}

class ListLong {
  ListLong._(this._bc, this._bcOffset);
  factory ListLong(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<ListLong> reader = _ListLongReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  List<int>? get val => const fb.ListReader<int>(fb.Int64Reader())
      .vTableGetNullable(_bc, _bcOffset, 4);

  @override
  String toString() {
    return 'ListLong{val: $val}';
  }
}

class _ListLongReader extends fb.TableReader<ListLong> {
  const _ListLongReader();

  @override
  ListLong createObject(fb.BufferContext bc, int offset) =>
      ListLong._(bc, offset);
}

class ListLongObjectBuilder extends WrapperObjectBuilder {
  final List<int> _val;

  ListLongObjectBuilder({
    required List<int> val,
  }) : assert(val.every((value) => value >= -9223372036854775808 && value <= 9223372036854775807), "Not a valid list of Long value"), _val = val;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    final int valOffset = fbBuilder.writeListInt64(_val);
    fbBuilder.startTable(1);
    fbBuilder.addOffset(0, valOffset);
    return fbBuilder.endTable();
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String? fileIdentifier]) {
    final fbBuilder = fb.Builder(deduplicateTables: false);
    fbBuilder.finish(finish(fbBuilder), fileIdentifier);
    return fbBuilder.buffer;
  }
}

class ListFloat {
  ListFloat._(this._bc, this._bcOffset);
  factory ListFloat(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<ListFloat> reader = _ListFloatReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  List<double>? get val => const fb.ListReader<double>(fb.Float32Reader())
      .vTableGetNullable(_bc, _bcOffset, 4);

  @override
  String toString() {
    return 'ListFloat{val: $val}';
  }
}

class _ListFloatReader extends fb.TableReader<ListFloat> {
  const _ListFloatReader();

  @override
  ListFloat createObject(fb.BufferContext bc, int offset) =>
      ListFloat._(bc, offset);
}

class ListFloatObjectBuilder extends WrapperObjectBuilder {
  final List<double> _val;

  ListFloatObjectBuilder({
   required List<double> val,
  }) : assert(val.every((value) => value >= -3.4028235e+38 && value <= 3.4028235e+38), "Not a valid list of Float Value"), _val = val;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    final int valOffset = fbBuilder.writeListFloat32(_val);
    fbBuilder.startTable(1);
    fbBuilder.addOffset(0, valOffset);
    return fbBuilder.endTable();
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String? fileIdentifier]) {
    final fbBuilder = fb.Builder(deduplicateTables: false);
    fbBuilder.finish(finish(fbBuilder), fileIdentifier);
    return fbBuilder.buffer;
  }
}

class ListDouble {
  ListDouble._(this._bc, this._bcOffset);
  factory ListDouble(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<ListDouble> reader = _ListDoubleReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  List<double>? get val => const fb.ListReader<double>(fb.Float64Reader())
      .vTableGetNullable(_bc, _bcOffset, 4);

  @override
  String toString() {
    return 'ListDouble{val: $val}';
  }
}

class _ListDoubleReader extends fb.TableReader<ListDouble> {
  const _ListDoubleReader();

  @override
  ListDouble createObject(fb.BufferContext bc, int offset) =>
      ListDouble._(bc, offset);
}

class ListDoubleObjectBuilder extends WrapperObjectBuilder {
  final List<double> _val;

  ListDoubleObjectBuilder({
    required List<double> val,
  }) : assert(val.every((value) => value >= -1.7976931348623157e+308 && value <= 1.7976931348623157e+308), "Not a valid list of Double Value"), _val = val;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    final int valOffset = fbBuilder.writeListFloat64(_val);
    fbBuilder.startTable(1);
    fbBuilder.addOffset(0, valOffset);
    return fbBuilder.endTable();
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String? fileIdentifier]) {
    final fbBuilder = fb.Builder(deduplicateTables: false);
    fbBuilder.finish(finish(fbBuilder), fileIdentifier);
    return fbBuilder.buffer;
  }
}

class ListBool {
  ListBool._(this._bc, this._bcOffset);
  factory ListBool(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<ListBool> reader = _ListBoolReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  List<bool>? get val => const fb.ListReader<bool>(fb.BoolReader())
      .vTableGetNullable(_bc, _bcOffset, 4);

  @override
  String toString() {
    return 'ListBool{val: $val}';
  }
}

class _ListBoolReader extends fb.TableReader<ListBool> {
  const _ListBoolReader();

  @override
  ListBool createObject(fb.BufferContext bc, int offset) =>
      ListBool._(bc, offset);
}

class ListBoolObjectBuilder extends WrapperObjectBuilder {
  final List<bool>? _val;

  ListBoolObjectBuilder({
    List<bool>? val,
  }) : _val = val;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    final int? valOffset = _val == null ? null : fbBuilder.writeListBool(_val);
    fbBuilder.startTable(1);
    fbBuilder.addOffset(0, valOffset);
    return fbBuilder.endTable();
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String? fileIdentifier]) {
    final fbBuilder = fb.Builder(deduplicateTables: false);
    fbBuilder.finish(finish(fbBuilder), fileIdentifier);
    return fbBuilder.buffer;
  }
}

class ComplexObject {
  ComplexObject._(this._bc, this._bcOffset);
  factory ComplexObject(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<ComplexObject> reader = _ComplexObjectReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  String? get name =>
      const fb.StringReader().vTableGetNullable(_bc, _bcOffset, 4);
  int get age => const fb.Int8Reader().vTableGet(_bc, _bcOffset, 6, 0);
  double get salary =>
      const fb.Float32Reader().vTableGet(_bc, _bcOffset, 8, 0.0);
  bool get isActive =>
      const fb.BoolReader().vTableGet(_bc, _bcOffset, 10, false);

  @override
  String toString() {
    return 'ComplexObject{name: $name, age: $age, salary: $salary, isActive: $isActive}';
  }
}

class _ComplexObjectReader extends fb.TableReader<ComplexObject> {
  const _ComplexObjectReader();

  @override
  ComplexObject createObject(fb.BufferContext bc, int offset) =>
      ComplexObject._(bc, offset);
}

class ComplexObjectObjectBuilder extends WrapperObjectBuilder {
  final String? _name;
  final int? _age;
  final double? _salary;
  final bool? _isActive;

  ComplexObjectObjectBuilder({
    String? name,
    int? age,
    double? salary,
    bool? isActive,
  })  : _name = name,
        _age = age,
        _salary = salary,
        _isActive = isActive;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    final int? nameOffset = _name == null ? null : fbBuilder.writeString(_name);
    fbBuilder.startTable(4);
    fbBuilder.addOffset(0, nameOffset);
    fbBuilder.addInt8(1, _age);
    fbBuilder.addFloat32(2, _salary);
    fbBuilder.addBool(3, _isActive);
    return fbBuilder.endTable();
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String? fileIdentifier]) {
    final fbBuilder = fb.Builder(deduplicateTables: false);
    fbBuilder.finish(finish(fbBuilder), fileIdentifier);
    return fbBuilder.buffer;
  }
}

class IntWrapper {
  IntWrapper._(this._bc, this._bcOffset);
  factory IntWrapper(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<IntWrapper> reader = _IntWrapperReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get val => const fb.Int32Reader().vTableGet(_bc, _bcOffset, 4, 0);

  @override
  String toString() {
    return 'IntWrapper{val: $val}';
  }
}

class _IntWrapperReader extends fb.TableReader<IntWrapper> {
  const _IntWrapperReader();

  @override
  IntWrapper createObject(fb.BufferContext bc, int offset) =>
      IntWrapper._(bc, offset);
}

class IntWrapperObjectBuilder extends WrapperObjectBuilder {
  final int _val;

  IntWrapperObjectBuilder({
    required int val,
  })  : assert(val >= -2147483648 && val <= 2147483647,
            'Value out of range for Int'),
        _val = val;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    fbBuilder.startTable(1);
    fbBuilder.addInt32(0, _val);
    return fbBuilder.endTable();
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String? fileIdentifier]) {
    final fbBuilder = fb.Builder(deduplicateTables: false);
    fbBuilder.finish(finish(fbBuilder), fileIdentifier);
    return fbBuilder.buffer;
  }
}

class DoubleWrapper {
  DoubleWrapper._(this._bc, this._bcOffset);
  factory DoubleWrapper(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<DoubleWrapper> reader = _DoubleWrapperReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  double get val => const fb.Float64Reader().vTableGet(_bc, _bcOffset, 4, 0.0);

  @override
  String toString() {
    return 'DoubleWrapper{val: $val}';
  }
}

class _DoubleWrapperReader extends fb.TableReader<DoubleWrapper> {
  const _DoubleWrapperReader();

  @override
  DoubleWrapper createObject(fb.BufferContext bc, int offset) =>
      DoubleWrapper._(bc, offset);
}

class DoubleWrapperObjectBuilder extends WrapperObjectBuilder {
  final double _val;

  DoubleWrapperObjectBuilder({
    required double val,
  })  : assert(
            val >= -1.7976931348623157e+308 && val <= 1.7976931348623157e+308,
            'Value out of range for Double'),
        _val = val;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    fbBuilder.startTable(1);
    fbBuilder.addFloat64(0, _val);
    return fbBuilder.endTable();
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String? fileIdentifier]) {
    final fbBuilder = fb.Builder(deduplicateTables: false);
    fbBuilder.finish(finish(fbBuilder), fileIdentifier);
    return fbBuilder.buffer;
  }
}

class FloatWrapper {
  FloatWrapper._(this._bc, this._bcOffset);
  factory FloatWrapper(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<FloatWrapper> reader = _FloatWrapperReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  double get val => const fb.Float32Reader().vTableGet(_bc, _bcOffset, 4, 0.0);

  @override
  String toString() {
    return 'FloatWrapper{val: $val}';
  }
}

class _FloatWrapperReader extends fb.TableReader<FloatWrapper> {
  const _FloatWrapperReader();

  @override
  FloatWrapper createObject(fb.BufferContext bc, int offset) =>
      FloatWrapper._(bc, offset);
}

class FloatWrapperObjectBuilder extends WrapperObjectBuilder {
  final double _val;

  FloatWrapperObjectBuilder({
    required double val,
  })  : assert(val >= -3.4028235e+38 && val <= 3.4028235e+38,
            'Value out of range for Float'),
        _val = val;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    fbBuilder.startTable(1);
    fbBuilder.addFloat32(0, _val);
    return fbBuilder.endTable();
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String? fileIdentifier]) {
    final fbBuilder = fb.Builder(deduplicateTables: false);
    fbBuilder.finish(finish(fbBuilder), fileIdentifier);
    return fbBuilder.buffer;
  }
}

class BoolWrapper {
  BoolWrapper._(this._bc, this._bcOffset);
  factory BoolWrapper(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<BoolWrapper> reader = _BoolWrapperReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  bool get val => const fb.BoolReader().vTableGet(_bc, _bcOffset, 4, false);

  @override
  String toString() {
    return 'BoolWrapper{val: $val}';
  }
}

class _BoolWrapperReader extends fb.TableReader<BoolWrapper> {
  const _BoolWrapperReader();

  @override
  BoolWrapper createObject(fb.BufferContext bc, int offset) =>
      BoolWrapper._(bc, offset);
}

class BoolWrapperObjectBuilder extends WrapperObjectBuilder {
  final bool? _val;

  BoolWrapperObjectBuilder({
    bool? val,
  }) : _val = val;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    fbBuilder.startTable(1);
    fbBuilder.addBool(0, _val);
    return fbBuilder.endTable();
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String? fileIdentifier]) {
    final fbBuilder = fb.Builder(deduplicateTables: false);
    fbBuilder.finish(finish(fbBuilder), fileIdentifier);
    return fbBuilder.buffer;
  }
}

class StringWrapper {
  StringWrapper._(this._bc, this._bcOffset);
  factory StringWrapper(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<StringWrapper> reader = _StringWrapperReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  String? get val =>
      const fb.StringReader().vTableGetNullable(_bc, _bcOffset, 4);

  @override
  String toString() {
    return 'StringWrapper{val: $val}';
  }
}

class _StringWrapperReader extends fb.TableReader<StringWrapper> {
  const _StringWrapperReader();

  @override
  StringWrapper createObject(fb.BufferContext bc, int offset) =>
      StringWrapper._(bc, offset);
}

class StringWrapperObjectBuilder extends WrapperObjectBuilder {
  final String? _val;

  StringWrapperObjectBuilder({
    String? val,
  }) : _val = val;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    final int? valOffset = _val == null ? null : fbBuilder.writeString(_val);
    fbBuilder.startTable(1);
    fbBuilder.addOffset(0, valOffset);
    return fbBuilder.endTable();
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String? fileIdentifier]) {
    final fbBuilder = fb.Builder(deduplicateTables: false);
    fbBuilder.finish(finish(fbBuilder), fileIdentifier);
    return fbBuilder.buffer;
  }
}

class ByteWrapper {
  ByteWrapper._(this._bc, this._bcOffset);
  factory ByteWrapper(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<ByteWrapper> reader = _ByteWrapperReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get val => const fb.Int8Reader().vTableGet(_bc, _bcOffset, 4, 0);

  @override
  String toString() {
    return 'ByteWrapper{val: $val}';
  }
}

class _ByteWrapperReader extends fb.TableReader<ByteWrapper> {
  const _ByteWrapperReader();

  @override
  ByteWrapper createObject(fb.BufferContext bc, int offset) =>
      ByteWrapper._(bc, offset);
}

class ByteWrapperObjectBuilder extends WrapperObjectBuilder {
  final int _val;

  ByteWrapperObjectBuilder({
    required int val,
  }) : assert(val >= -128 && val <= 127, 'Value out of range for Int8'), _val = val;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    fbBuilder.startTable(1);
    fbBuilder.addInt8(0, _val);
    return fbBuilder.endTable();
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String? fileIdentifier]) {
    final fbBuilder = fb.Builder(deduplicateTables: false);
    fbBuilder.finish(finish(fbBuilder), fileIdentifier);
    return fbBuilder.buffer;
  }
}

class LongWrapper {
  LongWrapper._(this._bc, this._bcOffset);
  factory LongWrapper(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<LongWrapper> reader = _LongWrapperReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get val => const fb.Int64Reader().vTableGet(_bc, _bcOffset, 4, 0);

  @override
  String toString() {
    return 'LongWrapper{val: $val}';
  }
}

class _LongWrapperReader extends fb.TableReader<LongWrapper> {
  const _LongWrapperReader();

  @override
  LongWrapper createObject(fb.BufferContext bc, int offset) =>
      LongWrapper._(bc, offset);
}

class LongWrapperObjectBuilder extends WrapperObjectBuilder {
  final int _val;

  LongWrapperObjectBuilder({
    required int val,
  })  : assert(val >= -9223372036854775808 && val <= 9223372036854775807,
            'Value out of range for Long'),
        _val = val;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    fbBuilder.startTable(1);
    fbBuilder.addInt64(0, _val);
    return fbBuilder.endTable();
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String? fileIdentifier]) {
    final fbBuilder = fb.Builder(deduplicateTables: false);
    fbBuilder.finish(finish(fbBuilder), fileIdentifier);
    return fbBuilder.buffer;
  }
}

class ShortWrapper {
  ShortWrapper._(this._bc, this._bcOffset);
  factory ShortWrapper(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<ShortWrapper> reader = _ShortWrapperReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get val => const fb.Int16Reader().vTableGet(_bc, _bcOffset, 4, 0);

  @override
  String toString() {
    return 'ShortWrapper{val: $val}';
  }
}

class _ShortWrapperReader extends fb.TableReader<ShortWrapper> {
  const _ShortWrapperReader();

  @override
  ShortWrapper createObject(fb.BufferContext bc, int offset) =>
      ShortWrapper._(bc, offset);
}

class ShortWrapperObjectBuilder extends WrapperObjectBuilder {
  final int _val;

  ShortWrapperObjectBuilder({
    required int val,
  })  : assert(val >= -32768 && val <= 32767, 'Value out of range for Short'),
        _val = val;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    fbBuilder.startTable(1);
    fbBuilder.addInt16(0, _val);
    return fbBuilder.endTable();
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String? fileIdentifier]) {
    final fbBuilder = fb.Builder(deduplicateTables: false);
    fbBuilder.finish(finish(fbBuilder), fileIdentifier);
    return fbBuilder.buffer;
  }
}

class KeyValue {
  KeyValue._(this._bc, this._bcOffset);
  factory KeyValue(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<KeyValue> reader = _KeyValueReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  String? get key =>
      const fb.StringReader().vTableGetNullable(_bc, _bcOffset, 4);
  AnyTypeId? get valType => AnyTypeId._createOrNull(
      const fb.Uint8Reader().vTableGetNullable(_bc, _bcOffset, 6));
  dynamic get val {
     switch (valType?.value) {
      case 1: return ListString.reader.vTableGetNullable(_bc, _bcOffset, 8);
      case 2: return ListInt.reader.vTableGetNullable(_bc, _bcOffset, 8);
      case 3: return ListShort.reader.vTableGetNullable(_bc, _bcOffset, 8);
      case 4: return ListLong.reader.vTableGetNullable(_bc, _bcOffset, 8);
      case 5: return ListFloat.reader.vTableGetNullable(_bc, _bcOffset, 8);
      case 6: return ListDouble.reader.vTableGetNullable(_bc, _bcOffset, 8);
      case 7: return ListBool.reader.vTableGetNullable(_bc, _bcOffset, 8);
      case 8: return ListByte.reader.vTableGetNullable(_bc, _bcOffset, 8);
      case 9: return ComplexObject.reader.vTableGetNullable(_bc, _bcOffset, 8);
      case 10: return IntWrapper.reader.vTableGetNullable(_bc, _bcOffset, 8);
      case 11: return DoubleWrapper.reader.vTableGetNullable(_bc, _bcOffset, 8);
      case 12: return BoolWrapper.reader.vTableGetNullable(_bc, _bcOffset, 8);
      case 13: return StringWrapper.reader.vTableGetNullable(_bc, _bcOffset, 8);
      case 14: return ByteWrapper.reader.vTableGetNullable(_bc, _bcOffset, 8);
      case 15: return LongWrapper.reader.vTableGetNullable(_bc, _bcOffset, 8);
      case 16: return ShortWrapper.reader.vTableGetNullable(_bc, _bcOffset, 8);
      case 17: return FloatWrapper.reader.vTableGetNullable(_bc, _bcOffset, 8);
      default: return null;
    }
  }

  @override
  String toString() {
    return 'KeyValue{key: $key, valType: $valType, val: $val}';
  }
}

class _KeyValueReader extends fb.TableReader<KeyValue> {
  const _KeyValueReader();

  @override
  KeyValue createObject(fb.BufferContext bc, int offset) =>
      KeyValue._(bc, offset);
}

class KeyValueObjectBuilder extends fb.ObjectBuilder {
  String key;
  AnyTypeId valType;
  WrapperObjectBuilder val;

  KeyValueObjectBuilder({
    required this.key,
    required this.valType,
    required this.val,
  });

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    final int keyOffset = fbBuilder.writeString(key);
    final int valOffset = val.getOrCreateOffset(fbBuilder);
    fbBuilder.startTable(3);
    fbBuilder.addOffset(0, keyOffset);
    fbBuilder.addUint8(1, valType.value);
    fbBuilder.addOffset(2, valOffset);
    return fbBuilder.endTable();
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String? fileIdentifier]) {
    final fbBuilder = fb.Builder(deduplicateTables: false);
    fbBuilder.finish(finish(fbBuilder), fileIdentifier);
    return fbBuilder.buffer;
  }
}

class KeyValueList {
  KeyValueList._(this._bc, this._bcOffset);
  factory KeyValueList(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<KeyValueList> reader = _KeyValueListReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  List<KeyValue>? get lists => const fb.ListReader<KeyValue>(KeyValue.reader)
      .vTableGetNullable(_bc, _bcOffset, 4);

  @override
  String toString() {
    return 'KeyValueList{lists: $lists}';
  }
}

class _KeyValueListReader extends fb.TableReader<KeyValueList> {
  const _KeyValueListReader();

  @override
  KeyValueList createObject(fb.BufferContext bc, int offset) =>
      KeyValueList._(bc, offset);
}

class KeyValueListBuilder {
  KeyValueListBuilder(this.fbBuilder);

  final fb.Builder fbBuilder;

  void begin() {
    fbBuilder.startTable(1);
  }

  int addListsOffset(int? offset) {
    fbBuilder.addOffset(0, offset);
    return fbBuilder.offset;
  }

  int finish() {
    return fbBuilder.endTable();
  }
}

class KeyValueListObjectBuilder extends fb.ObjectBuilder {
  final List<KeyValueObjectBuilder>? _lists;

  KeyValueListObjectBuilder({
    List<KeyValueObjectBuilder>? lists,
  }) : _lists = lists;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    final int? listsOffset = _lists == null
        ? null
        : fbBuilder.writeList(
            _lists.map((b) => b.getOrCreateOffset(fbBuilder)).toList());
    fbBuilder.startTable(1);
    fbBuilder.addOffset(0, listsOffset);
    return fbBuilder.endTable();
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String? fileIdentifier]) {
    final fbBuilder = fb.Builder(deduplicateTables: false);
    fbBuilder.finish(finish(fbBuilder), fileIdentifier);
    return fbBuilder.buffer;
  }
}
