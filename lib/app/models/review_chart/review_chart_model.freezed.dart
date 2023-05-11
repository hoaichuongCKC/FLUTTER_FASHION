// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_chart_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ReviewsModel _$ReviewsModelFromJson(Map<String, dynamic> json) {
  return _ReviewsModel.fromJson(json);
}

/// @nodoc
mixin _$ReviewsModel {
  int? get length => throw _privateConstructorUsedError;
  List<ReviewModel> get reviews => throw _privateConstructorUsedError;
  List<StarModel>? get star_group => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReviewsModelCopyWith<ReviewsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewsModelCopyWith<$Res> {
  factory $ReviewsModelCopyWith(
          ReviewsModel value, $Res Function(ReviewsModel) then) =
      _$ReviewsModelCopyWithImpl<$Res, ReviewsModel>;
  @useResult
  $Res call(
      {int? length, List<ReviewModel> reviews, List<StarModel>? star_group});
}

/// @nodoc
class _$ReviewsModelCopyWithImpl<$Res, $Val extends ReviewsModel>
    implements $ReviewsModelCopyWith<$Res> {
  _$ReviewsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? length = freezed,
    Object? reviews = null,
    Object? star_group = freezed,
  }) {
    return _then(_value.copyWith(
      length: freezed == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int?,
      reviews: null == reviews
          ? _value.reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<ReviewModel>,
      star_group: freezed == star_group
          ? _value.star_group
          : star_group // ignore: cast_nullable_to_non_nullable
              as List<StarModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ReviewsModelCopyWith<$Res>
    implements $ReviewsModelCopyWith<$Res> {
  factory _$$_ReviewsModelCopyWith(
          _$_ReviewsModel value, $Res Function(_$_ReviewsModel) then) =
      __$$_ReviewsModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? length, List<ReviewModel> reviews, List<StarModel>? star_group});
}

/// @nodoc
class __$$_ReviewsModelCopyWithImpl<$Res>
    extends _$ReviewsModelCopyWithImpl<$Res, _$_ReviewsModel>
    implements _$$_ReviewsModelCopyWith<$Res> {
  __$$_ReviewsModelCopyWithImpl(
      _$_ReviewsModel _value, $Res Function(_$_ReviewsModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? length = freezed,
    Object? reviews = null,
    Object? star_group = freezed,
  }) {
    return _then(_$_ReviewsModel(
      length: freezed == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int?,
      reviews: null == reviews
          ? _value._reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<ReviewModel>,
      star_group: freezed == star_group
          ? _value._star_group
          : star_group // ignore: cast_nullable_to_non_nullable
              as List<StarModel>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_ReviewsModel with DiagnosticableTreeMixin implements _ReviewsModel {
  const _$_ReviewsModel(
      {this.length,
      required final List<ReviewModel> reviews,
      final List<StarModel>? star_group})
      : _reviews = reviews,
        _star_group = star_group;

  factory _$_ReviewsModel.fromJson(Map<String, dynamic> json) =>
      _$$_ReviewsModelFromJson(json);

  @override
  final int? length;
  final List<ReviewModel> _reviews;
  @override
  List<ReviewModel> get reviews {
    if (_reviews is EqualUnmodifiableListView) return _reviews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reviews);
  }

  final List<StarModel>? _star_group;
  @override
  List<StarModel>? get star_group {
    final value = _star_group;
    if (value == null) return null;
    if (_star_group is EqualUnmodifiableListView) return _star_group;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ReviewsModel(length: $length, reviews: $reviews, star_group: $star_group)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ReviewsModel'))
      ..add(DiagnosticsProperty('length', length))
      ..add(DiagnosticsProperty('reviews', reviews))
      ..add(DiagnosticsProperty('star_group', star_group));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReviewsModel &&
            (identical(other.length, length) || other.length == length) &&
            const DeepCollectionEquality().equals(other._reviews, _reviews) &&
            const DeepCollectionEquality()
                .equals(other._star_group, _star_group));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      length,
      const DeepCollectionEquality().hash(_reviews),
      const DeepCollectionEquality().hash(_star_group));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReviewsModelCopyWith<_$_ReviewsModel> get copyWith =>
      __$$_ReviewsModelCopyWithImpl<_$_ReviewsModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReviewsModelToJson(
      this,
    );
  }
}

abstract class _ReviewsModel implements ReviewsModel {
  const factory _ReviewsModel(
      {final int? length,
      required final List<ReviewModel> reviews,
      final List<StarModel>? star_group}) = _$_ReviewsModel;

  factory _ReviewsModel.fromJson(Map<String, dynamic> json) =
      _$_ReviewsModel.fromJson;

  @override
  int? get length;
  @override
  List<ReviewModel> get reviews;
  @override
  List<StarModel>? get star_group;
  @override
  @JsonKey(ignore: true)
  _$$_ReviewsModelCopyWith<_$_ReviewsModel> get copyWith =>
      throw _privateConstructorUsedError;
}
