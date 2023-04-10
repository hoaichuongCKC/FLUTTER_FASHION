// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) {
  return _NotificationModel.fromJson(json);
}

/// @nodoc
mixin _$NotificationModel {
  int get id => throw _privateConstructorUsedError;
  int? get order_id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;
  int? get is_read => throw _privateConstructorUsedError;
  NotificationDetailModel? get detail => throw _privateConstructorUsedError;
  DateTime get created_at => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationModelCopyWith<NotificationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationModelCopyWith<$Res> {
  factory $NotificationModelCopyWith(
          NotificationModel value, $Res Function(NotificationModel) then) =
      _$NotificationModelCopyWithImpl<$Res, NotificationModel>;
  @useResult
  $Res call(
      {int id,
      int? order_id,
      String title,
      String subtitle,
      int? is_read,
      NotificationDetailModel? detail,
      DateTime created_at});

  $NotificationDetailModelCopyWith<$Res>? get detail;
}

/// @nodoc
class _$NotificationModelCopyWithImpl<$Res, $Val extends NotificationModel>
    implements $NotificationModelCopyWith<$Res> {
  _$NotificationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? order_id = freezed,
    Object? title = null,
    Object? subtitle = null,
    Object? is_read = freezed,
    Object? detail = freezed,
    Object? created_at = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      order_id: freezed == order_id
          ? _value.order_id
          : order_id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      is_read: freezed == is_read
          ? _value.is_read
          : is_read // ignore: cast_nullable_to_non_nullable
              as int?,
      detail: freezed == detail
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as NotificationDetailModel?,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NotificationDetailModelCopyWith<$Res>? get detail {
    if (_value.detail == null) {
      return null;
    }

    return $NotificationDetailModelCopyWith<$Res>(_value.detail!, (value) {
      return _then(_value.copyWith(detail: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_NotificationModelCopyWith<$Res>
    implements $NotificationModelCopyWith<$Res> {
  factory _$$_NotificationModelCopyWith(_$_NotificationModel value,
          $Res Function(_$_NotificationModel) then) =
      __$$_NotificationModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int? order_id,
      String title,
      String subtitle,
      int? is_read,
      NotificationDetailModel? detail,
      DateTime created_at});

  @override
  $NotificationDetailModelCopyWith<$Res>? get detail;
}

/// @nodoc
class __$$_NotificationModelCopyWithImpl<$Res>
    extends _$NotificationModelCopyWithImpl<$Res, _$_NotificationModel>
    implements _$$_NotificationModelCopyWith<$Res> {
  __$$_NotificationModelCopyWithImpl(
      _$_NotificationModel _value, $Res Function(_$_NotificationModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? order_id = freezed,
    Object? title = null,
    Object? subtitle = null,
    Object? is_read = freezed,
    Object? detail = freezed,
    Object? created_at = null,
  }) {
    return _then(_$_NotificationModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      order_id: freezed == order_id
          ? _value.order_id
          : order_id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      is_read: freezed == is_read
          ? _value.is_read
          : is_read // ignore: cast_nullable_to_non_nullable
              as int?,
      detail: freezed == detail
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as NotificationDetailModel?,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_NotificationModel implements _NotificationModel {
  const _$_NotificationModel(
      {required this.id,
      this.order_id,
      required this.title,
      required this.subtitle,
      this.is_read,
      this.detail,
      required this.created_at});

  factory _$_NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$$_NotificationModelFromJson(json);

  @override
  final int id;
  @override
  final int? order_id;
  @override
  final String title;
  @override
  final String subtitle;
  @override
  final int? is_read;
  @override
  final NotificationDetailModel? detail;
  @override
  final DateTime created_at;

  @override
  String toString() {
    return 'NotificationModel(id: $id, order_id: $order_id, title: $title, subtitle: $subtitle, is_read: $is_read, detail: $detail, created_at: $created_at)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NotificationModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.order_id, order_id) ||
                other.order_id == order_id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.is_read, is_read) || other.is_read == is_read) &&
            (identical(other.detail, detail) || other.detail == detail) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, order_id, title, subtitle, is_read, detail, created_at);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NotificationModelCopyWith<_$_NotificationModel> get copyWith =>
      __$$_NotificationModelCopyWithImpl<_$_NotificationModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NotificationModelToJson(
      this,
    );
  }
}

abstract class _NotificationModel implements NotificationModel {
  const factory _NotificationModel(
      {required final int id,
      final int? order_id,
      required final String title,
      required final String subtitle,
      final int? is_read,
      final NotificationDetailModel? detail,
      required final DateTime created_at}) = _$_NotificationModel;

  factory _NotificationModel.fromJson(Map<String, dynamic> json) =
      _$_NotificationModel.fromJson;

  @override
  int get id;
  @override
  int? get order_id;
  @override
  String get title;
  @override
  String get subtitle;
  @override
  int? get is_read;
  @override
  NotificationDetailModel? get detail;
  @override
  DateTime get created_at;
  @override
  @JsonKey(ignore: true)
  _$$_NotificationModelCopyWith<_$_NotificationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationDetailModel _$NotificationDetailModelFromJson(
    Map<String, dynamic> json) {
  return _NotificationDetailModel.fromJson(json);
}

/// @nodoc
mixin _$NotificationDetailModel {
  int get id => throw _privateConstructorUsedError;
  int get is_read => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationDetailModelCopyWith<NotificationDetailModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationDetailModelCopyWith<$Res> {
  factory $NotificationDetailModelCopyWith(NotificationDetailModel value,
          $Res Function(NotificationDetailModel) then) =
      _$NotificationDetailModelCopyWithImpl<$Res, NotificationDetailModel>;
  @useResult
  $Res call({int id, int is_read});
}

/// @nodoc
class _$NotificationDetailModelCopyWithImpl<$Res,
        $Val extends NotificationDetailModel>
    implements $NotificationDetailModelCopyWith<$Res> {
  _$NotificationDetailModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? is_read = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      is_read: null == is_read
          ? _value.is_read
          : is_read // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NotificationDetailModelCopyWith<$Res>
    implements $NotificationDetailModelCopyWith<$Res> {
  factory _$$_NotificationDetailModelCopyWith(_$_NotificationDetailModel value,
          $Res Function(_$_NotificationDetailModel) then) =
      __$$_NotificationDetailModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int is_read});
}

/// @nodoc
class __$$_NotificationDetailModelCopyWithImpl<$Res>
    extends _$NotificationDetailModelCopyWithImpl<$Res,
        _$_NotificationDetailModel>
    implements _$$_NotificationDetailModelCopyWith<$Res> {
  __$$_NotificationDetailModelCopyWithImpl(_$_NotificationDetailModel _value,
      $Res Function(_$_NotificationDetailModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? is_read = null,
  }) {
    return _then(_$_NotificationDetailModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      is_read: null == is_read
          ? _value.is_read
          : is_read // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_NotificationDetailModel implements _NotificationDetailModel {
  const _$_NotificationDetailModel({required this.id, required this.is_read});

  factory _$_NotificationDetailModel.fromJson(Map<String, dynamic> json) =>
      _$$_NotificationDetailModelFromJson(json);

  @override
  final int id;
  @override
  final int is_read;

  @override
  String toString() {
    return 'NotificationDetailModel(id: $id, is_read: $is_read)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NotificationDetailModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.is_read, is_read) || other.is_read == is_read));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, is_read);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NotificationDetailModelCopyWith<_$_NotificationDetailModel>
      get copyWith =>
          __$$_NotificationDetailModelCopyWithImpl<_$_NotificationDetailModel>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NotificationDetailModelToJson(
      this,
    );
  }
}

abstract class _NotificationDetailModel implements NotificationDetailModel {
  const factory _NotificationDetailModel(
      {required final int id,
      required final int is_read}) = _$_NotificationDetailModel;

  factory _NotificationDetailModel.fromJson(Map<String, dynamic> json) =
      _$_NotificationDetailModel.fromJson;

  @override
  int get id;
  @override
  int get is_read;
  @override
  @JsonKey(ignore: true)
  _$$_NotificationDetailModelCopyWith<_$_NotificationDetailModel>
      get copyWith => throw _privateConstructorUsedError;
}
