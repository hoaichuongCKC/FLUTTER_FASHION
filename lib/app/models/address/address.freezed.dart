// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ItemProvinceModel _$ItemProvinceModelFromJson(Map<String, dynamic> json) {
  return _ItemProvinceModel.fromJson(json);
}

/// @nodoc
mixin _$ItemProvinceModel {
  String get idProvince => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemProvinceModelCopyWith<ItemProvinceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemProvinceModelCopyWith<$Res> {
  factory $ItemProvinceModelCopyWith(
          ItemProvinceModel value, $Res Function(ItemProvinceModel) then) =
      _$ItemProvinceModelCopyWithImpl<$Res, ItemProvinceModel>;
  @useResult
  $Res call({String idProvince, String name});
}

/// @nodoc
class _$ItemProvinceModelCopyWithImpl<$Res, $Val extends ItemProvinceModel>
    implements $ItemProvinceModelCopyWith<$Res> {
  _$ItemProvinceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idProvince = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      idProvince: null == idProvince
          ? _value.idProvince
          : idProvince // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ItemProvinceModelCopyWith<$Res>
    implements $ItemProvinceModelCopyWith<$Res> {
  factory _$$_ItemProvinceModelCopyWith(_$_ItemProvinceModel value,
          $Res Function(_$_ItemProvinceModel) then) =
      __$$_ItemProvinceModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String idProvince, String name});
}

/// @nodoc
class __$$_ItemProvinceModelCopyWithImpl<$Res>
    extends _$ItemProvinceModelCopyWithImpl<$Res, _$_ItemProvinceModel>
    implements _$$_ItemProvinceModelCopyWith<$Res> {
  __$$_ItemProvinceModelCopyWithImpl(
      _$_ItemProvinceModel _value, $Res Function(_$_ItemProvinceModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idProvince = null,
    Object? name = null,
  }) {
    return _then(_$_ItemProvinceModel(
      idProvince: null == idProvince
          ? _value.idProvince
          : idProvince // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_ItemProvinceModel implements _ItemProvinceModel {
  const _$_ItemProvinceModel({required this.idProvince, required this.name});

  factory _$_ItemProvinceModel.fromJson(Map<String, dynamic> json) =>
      _$$_ItemProvinceModelFromJson(json);

  @override
  final String idProvince;
  @override
  final String name;

  @override
  String toString() {
    return 'ItemProvinceModel(idProvince: $idProvince, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ItemProvinceModel &&
            (identical(other.idProvince, idProvince) ||
                other.idProvince == idProvince) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, idProvince, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ItemProvinceModelCopyWith<_$_ItemProvinceModel> get copyWith =>
      __$$_ItemProvinceModelCopyWithImpl<_$_ItemProvinceModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ItemProvinceModelToJson(
      this,
    );
  }
}

abstract class _ItemProvinceModel implements ItemProvinceModel {
  const factory _ItemProvinceModel(
      {required final String idProvince,
      required final String name}) = _$_ItemProvinceModel;

  factory _ItemProvinceModel.fromJson(Map<String, dynamic> json) =
      _$_ItemProvinceModel.fromJson;

  @override
  String get idProvince;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_ItemProvinceModelCopyWith<_$_ItemProvinceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

ItemDistrictModel _$ItemDistrictModelFromJson(Map<String, dynamic> json) {
  return _ItemDistrictModel.fromJson(json);
}

/// @nodoc
mixin _$ItemDistrictModel {
  String get idProvince => throw _privateConstructorUsedError;
  String get idDistrict => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemDistrictModelCopyWith<ItemDistrictModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemDistrictModelCopyWith<$Res> {
  factory $ItemDistrictModelCopyWith(
          ItemDistrictModel value, $Res Function(ItemDistrictModel) then) =
      _$ItemDistrictModelCopyWithImpl<$Res, ItemDistrictModel>;
  @useResult
  $Res call({String idProvince, String idDistrict, String name});
}

/// @nodoc
class _$ItemDistrictModelCopyWithImpl<$Res, $Val extends ItemDistrictModel>
    implements $ItemDistrictModelCopyWith<$Res> {
  _$ItemDistrictModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idProvince = null,
    Object? idDistrict = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      idProvince: null == idProvince
          ? _value.idProvince
          : idProvince // ignore: cast_nullable_to_non_nullable
              as String,
      idDistrict: null == idDistrict
          ? _value.idDistrict
          : idDistrict // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ItemDistrictModelCopyWith<$Res>
    implements $ItemDistrictModelCopyWith<$Res> {
  factory _$$_ItemDistrictModelCopyWith(_$_ItemDistrictModel value,
          $Res Function(_$_ItemDistrictModel) then) =
      __$$_ItemDistrictModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String idProvince, String idDistrict, String name});
}

/// @nodoc
class __$$_ItemDistrictModelCopyWithImpl<$Res>
    extends _$ItemDistrictModelCopyWithImpl<$Res, _$_ItemDistrictModel>
    implements _$$_ItemDistrictModelCopyWith<$Res> {
  __$$_ItemDistrictModelCopyWithImpl(
      _$_ItemDistrictModel _value, $Res Function(_$_ItemDistrictModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idProvince = null,
    Object? idDistrict = null,
    Object? name = null,
  }) {
    return _then(_$_ItemDistrictModel(
      idProvince: null == idProvince
          ? _value.idProvince
          : idProvince // ignore: cast_nullable_to_non_nullable
              as String,
      idDistrict: null == idDistrict
          ? _value.idDistrict
          : idDistrict // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_ItemDistrictModel implements _ItemDistrictModel {
  const _$_ItemDistrictModel(
      {required this.idProvince, required this.idDistrict, required this.name});

  factory _$_ItemDistrictModel.fromJson(Map<String, dynamic> json) =>
      _$$_ItemDistrictModelFromJson(json);

  @override
  final String idProvince;
  @override
  final String idDistrict;
  @override
  final String name;

  @override
  String toString() {
    return 'ItemDistrictModel(idProvince: $idProvince, idDistrict: $idDistrict, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ItemDistrictModel &&
            (identical(other.idProvince, idProvince) ||
                other.idProvince == idProvince) &&
            (identical(other.idDistrict, idDistrict) ||
                other.idDistrict == idDistrict) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, idProvince, idDistrict, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ItemDistrictModelCopyWith<_$_ItemDistrictModel> get copyWith =>
      __$$_ItemDistrictModelCopyWithImpl<_$_ItemDistrictModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ItemDistrictModelToJson(
      this,
    );
  }
}

abstract class _ItemDistrictModel implements ItemDistrictModel {
  const factory _ItemDistrictModel(
      {required final String idProvince,
      required final String idDistrict,
      required final String name}) = _$_ItemDistrictModel;

  factory _ItemDistrictModel.fromJson(Map<String, dynamic> json) =
      _$_ItemDistrictModel.fromJson;

  @override
  String get idProvince;
  @override
  String get idDistrict;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_ItemDistrictModelCopyWith<_$_ItemDistrictModel> get copyWith =>
      throw _privateConstructorUsedError;
}

ItemCommuneModel _$ItemCommuneModelFromJson(Map<String, dynamic> json) {
  return _ItemCommuneModel.fromJson(json);
}

/// @nodoc
mixin _$ItemCommuneModel {
  String get idDistrict => throw _privateConstructorUsedError;
  String get idCommune => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemCommuneModelCopyWith<ItemCommuneModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemCommuneModelCopyWith<$Res> {
  factory $ItemCommuneModelCopyWith(
          ItemCommuneModel value, $Res Function(ItemCommuneModel) then) =
      _$ItemCommuneModelCopyWithImpl<$Res, ItemCommuneModel>;
  @useResult
  $Res call({String idDistrict, String idCommune, String name});
}

/// @nodoc
class _$ItemCommuneModelCopyWithImpl<$Res, $Val extends ItemCommuneModel>
    implements $ItemCommuneModelCopyWith<$Res> {
  _$ItemCommuneModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idDistrict = null,
    Object? idCommune = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      idDistrict: null == idDistrict
          ? _value.idDistrict
          : idDistrict // ignore: cast_nullable_to_non_nullable
              as String,
      idCommune: null == idCommune
          ? _value.idCommune
          : idCommune // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ItemCommuneModelCopyWith<$Res>
    implements $ItemCommuneModelCopyWith<$Res> {
  factory _$$_ItemCommuneModelCopyWith(
          _$_ItemCommuneModel value, $Res Function(_$_ItemCommuneModel) then) =
      __$$_ItemCommuneModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String idDistrict, String idCommune, String name});
}

/// @nodoc
class __$$_ItemCommuneModelCopyWithImpl<$Res>
    extends _$ItemCommuneModelCopyWithImpl<$Res, _$_ItemCommuneModel>
    implements _$$_ItemCommuneModelCopyWith<$Res> {
  __$$_ItemCommuneModelCopyWithImpl(
      _$_ItemCommuneModel _value, $Res Function(_$_ItemCommuneModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idDistrict = null,
    Object? idCommune = null,
    Object? name = null,
  }) {
    return _then(_$_ItemCommuneModel(
      idDistrict: null == idDistrict
          ? _value.idDistrict
          : idDistrict // ignore: cast_nullable_to_non_nullable
              as String,
      idCommune: null == idCommune
          ? _value.idCommune
          : idCommune // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_ItemCommuneModel implements _ItemCommuneModel {
  const _$_ItemCommuneModel(
      {required this.idDistrict, required this.idCommune, required this.name});

  factory _$_ItemCommuneModel.fromJson(Map<String, dynamic> json) =>
      _$$_ItemCommuneModelFromJson(json);

  @override
  final String idDistrict;
  @override
  final String idCommune;
  @override
  final String name;

  @override
  String toString() {
    return 'ItemCommuneModel(idDistrict: $idDistrict, idCommune: $idCommune, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ItemCommuneModel &&
            (identical(other.idDistrict, idDistrict) ||
                other.idDistrict == idDistrict) &&
            (identical(other.idCommune, idCommune) ||
                other.idCommune == idCommune) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, idDistrict, idCommune, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ItemCommuneModelCopyWith<_$_ItemCommuneModel> get copyWith =>
      __$$_ItemCommuneModelCopyWithImpl<_$_ItemCommuneModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ItemCommuneModelToJson(
      this,
    );
  }
}

abstract class _ItemCommuneModel implements ItemCommuneModel {
  const factory _ItemCommuneModel(
      {required final String idDistrict,
      required final String idCommune,
      required final String name}) = _$_ItemCommuneModel;

  factory _ItemCommuneModel.fromJson(Map<String, dynamic> json) =
      _$_ItemCommuneModel.fromJson;

  @override
  String get idDistrict;
  @override
  String get idCommune;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_ItemCommuneModelCopyWith<_$_ItemCommuneModel> get copyWith =>
      throw _privateConstructorUsedError;
}
