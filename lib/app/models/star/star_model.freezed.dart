// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'star_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StarModel _$StarModelFromJson(Map<String, dynamic> json) {
  return _StarModel.fromJson(json);
}

/// @nodoc
mixin _$StarModel {
  int get star => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StarModelCopyWith<StarModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StarModelCopyWith<$Res> {
  factory $StarModelCopyWith(StarModel value, $Res Function(StarModel) then) =
      _$StarModelCopyWithImpl<$Res, StarModel>;
  @useResult
  $Res call({int star, int count});
}

/// @nodoc
class _$StarModelCopyWithImpl<$Res, $Val extends StarModel>
    implements $StarModelCopyWith<$Res> {
  _$StarModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? star = null,
    Object? count = null,
  }) {
    return _then(_value.copyWith(
      star: null == star
          ? _value.star
          : star // ignore: cast_nullable_to_non_nullable
              as int,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StarModelCopyWith<$Res> implements $StarModelCopyWith<$Res> {
  factory _$$_StarModelCopyWith(
          _$_StarModel value, $Res Function(_$_StarModel) then) =
      __$$_StarModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int star, int count});
}

/// @nodoc
class __$$_StarModelCopyWithImpl<$Res>
    extends _$StarModelCopyWithImpl<$Res, _$_StarModel>
    implements _$$_StarModelCopyWith<$Res> {
  __$$_StarModelCopyWithImpl(
      _$_StarModel _value, $Res Function(_$_StarModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? star = null,
    Object? count = null,
  }) {
    return _then(_$_StarModel(
      star: null == star
          ? _value.star
          : star // ignore: cast_nullable_to_non_nullable
              as int,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_StarModel implements _StarModel {
  const _$_StarModel({required this.star, required this.count});

  factory _$_StarModel.fromJson(Map<String, dynamic> json) =>
      _$$_StarModelFromJson(json);

  @override
  final int star;
  @override
  final int count;

  @override
  String toString() {
    return 'StarModel(star: $star, count: $count)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StarModel &&
            (identical(other.star, star) || other.star == star) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, star, count);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StarModelCopyWith<_$_StarModel> get copyWith =>
      __$$_StarModelCopyWithImpl<_$_StarModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StarModelToJson(
      this,
    );
  }
}

abstract class _StarModel implements StarModel {
  const factory _StarModel(
      {required final int star, required final int count}) = _$_StarModel;

  factory _StarModel.fromJson(Map<String, dynamic> json) =
      _$_StarModel.fromJson;

  @override
  int get star;
  @override
  int get count;
  @override
  @JsonKey(ignore: true)
  _$$_StarModelCopyWith<_$_StarModel> get copyWith =>
      throw _privateConstructorUsedError;
}
