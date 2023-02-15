// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'response_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ResponseData _$ResponseDataFromJson(Map<String, dynamic> json) {
  return _ResponseData.fromJson(json);
}

/// @nodoc
mixin _$ResponseData {
  bool get status => throw _privateConstructorUsedError;
  dynamic get data => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResponseDataCopyWith<ResponseData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResponseDataCopyWith<$Res> {
  factory $ResponseDataCopyWith(
          ResponseData value, $Res Function(ResponseData) then) =
      _$ResponseDataCopyWithImpl<$Res, ResponseData>;
  @useResult
  $Res call({bool status, dynamic data, String message});
}

/// @nodoc
class _$ResponseDataCopyWithImpl<$Res, $Val extends ResponseData>
    implements $ResponseDataCopyWith<$Res> {
  _$ResponseDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? data = freezed,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ResponseDataCopyWith<$Res>
    implements $ResponseDataCopyWith<$Res> {
  factory _$$_ResponseDataCopyWith(
          _$_ResponseData value, $Res Function(_$_ResponseData) then) =
      __$$_ResponseDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool status, dynamic data, String message});
}

/// @nodoc
class __$$_ResponseDataCopyWithImpl<$Res>
    extends _$ResponseDataCopyWithImpl<$Res, _$_ResponseData>
    implements _$$_ResponseDataCopyWith<$Res> {
  __$$_ResponseDataCopyWithImpl(
      _$_ResponseData _value, $Res Function(_$_ResponseData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? data = freezed,
    Object? message = null,
  }) {
    return _then(_$_ResponseData(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_ResponseData implements _ResponseData {
  const _$_ResponseData(
      {this.status = false, required this.data, this.message = ""});

  factory _$_ResponseData.fromJson(Map<String, dynamic> json) =>
      _$$_ResponseDataFromJson(json);

  @override
  @JsonKey()
  final bool status;
  @override
  final dynamic data;
  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'ResponseData(status: $status, data: $data, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ResponseData &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, status, const DeepCollectionEquality().hash(data), message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ResponseDataCopyWith<_$_ResponseData> get copyWith =>
      __$$_ResponseDataCopyWithImpl<_$_ResponseData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ResponseDataToJson(
      this,
    );
  }
}

abstract class _ResponseData implements ResponseData {
  const factory _ResponseData(
      {final bool status,
      required final dynamic data,
      final String message}) = _$_ResponseData;

  factory _ResponseData.fromJson(Map<String, dynamic> json) =
      _$_ResponseData.fromJson;

  @override
  bool get status;
  @override
  dynamic get data;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$_ResponseDataCopyWith<_$_ResponseData> get copyWith =>
      throw _privateConstructorUsedError;
}
