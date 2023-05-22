// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) {
  return _OrderModel.fromJson(json);
}

/// @nodoc
mixin _$OrderModel {
  int? get id => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  String? get shipping_fullname => throw _privateConstructorUsedError;
  String? get shipping_phone => throw _privateConstructorUsedError;
  String? get shipping_address => throw _privateConstructorUsedError;
  String? get order_payment => throw _privateConstructorUsedError;
  int? get temp_price => throw _privateConstructorUsedError;
  int? get total_price => throw _privateConstructorUsedError;
  PromotionModel? get promotion => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  int? get status_id => throw _privateConstructorUsedError;
  DateTime? get created_at => throw _privateConstructorUsedError;
  List<CartModel>? get order_detail => throw _privateConstructorUsedError;
  bool? get evaluated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderModelCopyWith<OrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderModelCopyWith<$Res> {
  factory $OrderModelCopyWith(
          OrderModel value, $Res Function(OrderModel) then) =
      _$OrderModelCopyWithImpl<$Res, OrderModel>;
  @useResult
  $Res call(
      {int? id,
      String? code,
      String? shipping_fullname,
      String? shipping_phone,
      String? shipping_address,
      String? order_payment,
      int? temp_price,
      int? total_price,
      PromotionModel? promotion,
      String? notes,
      int? status_id,
      DateTime? created_at,
      List<CartModel>? order_detail,
      bool? evaluated});

  $PromotionModelCopyWith<$Res>? get promotion;
}

/// @nodoc
class _$OrderModelCopyWithImpl<$Res, $Val extends OrderModel>
    implements $OrderModelCopyWith<$Res> {
  _$OrderModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? code = freezed,
    Object? shipping_fullname = freezed,
    Object? shipping_phone = freezed,
    Object? shipping_address = freezed,
    Object? order_payment = freezed,
    Object? temp_price = freezed,
    Object? total_price = freezed,
    Object? promotion = freezed,
    Object? notes = freezed,
    Object? status_id = freezed,
    Object? created_at = freezed,
    Object? order_detail = freezed,
    Object? evaluated = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      shipping_fullname: freezed == shipping_fullname
          ? _value.shipping_fullname
          : shipping_fullname // ignore: cast_nullable_to_non_nullable
              as String?,
      shipping_phone: freezed == shipping_phone
          ? _value.shipping_phone
          : shipping_phone // ignore: cast_nullable_to_non_nullable
              as String?,
      shipping_address: freezed == shipping_address
          ? _value.shipping_address
          : shipping_address // ignore: cast_nullable_to_non_nullable
              as String?,
      order_payment: freezed == order_payment
          ? _value.order_payment
          : order_payment // ignore: cast_nullable_to_non_nullable
              as String?,
      temp_price: freezed == temp_price
          ? _value.temp_price
          : temp_price // ignore: cast_nullable_to_non_nullable
              as int?,
      total_price: freezed == total_price
          ? _value.total_price
          : total_price // ignore: cast_nullable_to_non_nullable
              as int?,
      promotion: freezed == promotion
          ? _value.promotion
          : promotion // ignore: cast_nullable_to_non_nullable
              as PromotionModel?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      status_id: freezed == status_id
          ? _value.status_id
          : status_id // ignore: cast_nullable_to_non_nullable
              as int?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      order_detail: freezed == order_detail
          ? _value.order_detail
          : order_detail // ignore: cast_nullable_to_non_nullable
              as List<CartModel>?,
      evaluated: freezed == evaluated
          ? _value.evaluated
          : evaluated // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PromotionModelCopyWith<$Res>? get promotion {
    if (_value.promotion == null) {
      return null;
    }

    return $PromotionModelCopyWith<$Res>(_value.promotion!, (value) {
      return _then(_value.copyWith(promotion: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_OrderModelCopyWith<$Res>
    implements $OrderModelCopyWith<$Res> {
  factory _$$_OrderModelCopyWith(
          _$_OrderModel value, $Res Function(_$_OrderModel) then) =
      __$$_OrderModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? code,
      String? shipping_fullname,
      String? shipping_phone,
      String? shipping_address,
      String? order_payment,
      int? temp_price,
      int? total_price,
      PromotionModel? promotion,
      String? notes,
      int? status_id,
      DateTime? created_at,
      List<CartModel>? order_detail,
      bool? evaluated});

  @override
  $PromotionModelCopyWith<$Res>? get promotion;
}

/// @nodoc
class __$$_OrderModelCopyWithImpl<$Res>
    extends _$OrderModelCopyWithImpl<$Res, _$_OrderModel>
    implements _$$_OrderModelCopyWith<$Res> {
  __$$_OrderModelCopyWithImpl(
      _$_OrderModel _value, $Res Function(_$_OrderModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? code = freezed,
    Object? shipping_fullname = freezed,
    Object? shipping_phone = freezed,
    Object? shipping_address = freezed,
    Object? order_payment = freezed,
    Object? temp_price = freezed,
    Object? total_price = freezed,
    Object? promotion = freezed,
    Object? notes = freezed,
    Object? status_id = freezed,
    Object? created_at = freezed,
    Object? order_detail = freezed,
    Object? evaluated = freezed,
  }) {
    return _then(_$_OrderModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      shipping_fullname: freezed == shipping_fullname
          ? _value.shipping_fullname
          : shipping_fullname // ignore: cast_nullable_to_non_nullable
              as String?,
      shipping_phone: freezed == shipping_phone
          ? _value.shipping_phone
          : shipping_phone // ignore: cast_nullable_to_non_nullable
              as String?,
      shipping_address: freezed == shipping_address
          ? _value.shipping_address
          : shipping_address // ignore: cast_nullable_to_non_nullable
              as String?,
      order_payment: freezed == order_payment
          ? _value.order_payment
          : order_payment // ignore: cast_nullable_to_non_nullable
              as String?,
      temp_price: freezed == temp_price
          ? _value.temp_price
          : temp_price // ignore: cast_nullable_to_non_nullable
              as int?,
      total_price: freezed == total_price
          ? _value.total_price
          : total_price // ignore: cast_nullable_to_non_nullable
              as int?,
      promotion: freezed == promotion
          ? _value.promotion
          : promotion // ignore: cast_nullable_to_non_nullable
              as PromotionModel?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      status_id: freezed == status_id
          ? _value.status_id
          : status_id // ignore: cast_nullable_to_non_nullable
              as int?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      order_detail: freezed == order_detail
          ? _value._order_detail
          : order_detail // ignore: cast_nullable_to_non_nullable
              as List<CartModel>?,
      evaluated: freezed == evaluated
          ? _value.evaluated
          : evaluated // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_OrderModel implements _OrderModel {
  _$_OrderModel(
      {this.id,
      this.code,
      this.shipping_fullname,
      this.shipping_phone,
      this.shipping_address,
      this.order_payment,
      this.temp_price,
      this.total_price,
      this.promotion,
      this.notes,
      this.status_id,
      this.created_at,
      final List<CartModel>? order_detail,
      this.evaluated})
      : _order_detail = order_detail;

  factory _$_OrderModel.fromJson(Map<String, dynamic> json) =>
      _$$_OrderModelFromJson(json);

  @override
  final int? id;
  @override
  final String? code;
  @override
  final String? shipping_fullname;
  @override
  final String? shipping_phone;
  @override
  final String? shipping_address;
  @override
  final String? order_payment;
  @override
  final int? temp_price;
  @override
  final int? total_price;
  @override
  final PromotionModel? promotion;
  @override
  final String? notes;
  @override
  final int? status_id;
  @override
  final DateTime? created_at;
  final List<CartModel>? _order_detail;
  @override
  List<CartModel>? get order_detail {
    final value = _order_detail;
    if (value == null) return null;
    if (_order_detail is EqualUnmodifiableListView) return _order_detail;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? evaluated;

  @override
  String toString() {
    return 'OrderModel(id: $id, code: $code, shipping_fullname: $shipping_fullname, shipping_phone: $shipping_phone, shipping_address: $shipping_address, order_payment: $order_payment, temp_price: $temp_price, total_price: $total_price, promotion: $promotion, notes: $notes, status_id: $status_id, created_at: $created_at, order_detail: $order_detail, evaluated: $evaluated)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OrderModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.shipping_fullname, shipping_fullname) ||
                other.shipping_fullname == shipping_fullname) &&
            (identical(other.shipping_phone, shipping_phone) ||
                other.shipping_phone == shipping_phone) &&
            (identical(other.shipping_address, shipping_address) ||
                other.shipping_address == shipping_address) &&
            (identical(other.order_payment, order_payment) ||
                other.order_payment == order_payment) &&
            (identical(other.temp_price, temp_price) ||
                other.temp_price == temp_price) &&
            (identical(other.total_price, total_price) ||
                other.total_price == total_price) &&
            (identical(other.promotion, promotion) ||
                other.promotion == promotion) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.status_id, status_id) ||
                other.status_id == status_id) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            const DeepCollectionEquality()
                .equals(other._order_detail, _order_detail) &&
            (identical(other.evaluated, evaluated) ||
                other.evaluated == evaluated));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      code,
      shipping_fullname,
      shipping_phone,
      shipping_address,
      order_payment,
      temp_price,
      total_price,
      promotion,
      notes,
      status_id,
      created_at,
      const DeepCollectionEquality().hash(_order_detail),
      evaluated);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OrderModelCopyWith<_$_OrderModel> get copyWith =>
      __$$_OrderModelCopyWithImpl<_$_OrderModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OrderModelToJson(
      this,
    );
  }
}

abstract class _OrderModel implements OrderModel {
  factory _OrderModel(
      {final int? id,
      final String? code,
      final String? shipping_fullname,
      final String? shipping_phone,
      final String? shipping_address,
      final String? order_payment,
      final int? temp_price,
      final int? total_price,
      final PromotionModel? promotion,
      final String? notes,
      final int? status_id,
      final DateTime? created_at,
      final List<CartModel>? order_detail,
      final bool? evaluated}) = _$_OrderModel;

  factory _OrderModel.fromJson(Map<String, dynamic> json) =
      _$_OrderModel.fromJson;

  @override
  int? get id;
  @override
  String? get code;
  @override
  String? get shipping_fullname;
  @override
  String? get shipping_phone;
  @override
  String? get shipping_address;
  @override
  String? get order_payment;
  @override
  int? get temp_price;
  @override
  int? get total_price;
  @override
  PromotionModel? get promotion;
  @override
  String? get notes;
  @override
  int? get status_id;
  @override
  DateTime? get created_at;
  @override
  List<CartModel>? get order_detail;
  @override
  bool? get evaluated;
  @override
  @JsonKey(ignore: true)
  _$$_OrderModelCopyWith<_$_OrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}
