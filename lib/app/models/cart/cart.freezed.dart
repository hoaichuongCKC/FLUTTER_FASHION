// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CartModel _$CartModelFromJson(Map<String, dynamic> json) {
  return _CartModel.fromJson(json);
}

/// @nodoc
mixin _$CartModel {
  ProductModel get product => throw _privateConstructorUsedError;
  int get product_detail_id => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  int? get sale_price => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  String get size => throw _privateConstructorUsedError;
  String get photo => throw _privateConstructorUsedError;
  DateTime get created_at => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CartModelCopyWith<CartModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartModelCopyWith<$Res> {
  factory $CartModelCopyWith(CartModel value, $Res Function(CartModel) then) =
      _$CartModelCopyWithImpl<$Res, CartModel>;
  @useResult
  $Res call(
      {ProductModel product,
      int product_detail_id,
      int price,
      int? sale_price,
      int quantity,
      String color,
      String size,
      String photo,
      DateTime created_at});

  $ProductModelCopyWith<$Res> get product;
}

/// @nodoc
class _$CartModelCopyWithImpl<$Res, $Val extends CartModel>
    implements $CartModelCopyWith<$Res> {
  _$CartModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = null,
    Object? product_detail_id = null,
    Object? price = null,
    Object? sale_price = freezed,
    Object? quantity = null,
    Object? color = null,
    Object? size = null,
    Object? photo = null,
    Object? created_at = null,
  }) {
    return _then(_value.copyWith(
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductModel,
      product_detail_id: null == product_detail_id
          ? _value.product_detail_id
          : product_detail_id // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      sale_price: freezed == sale_price
          ? _value.sale_price
          : sale_price // ignore: cast_nullable_to_non_nullable
              as int?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String,
      photo: null == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductModelCopyWith<$Res> get product {
    return $ProductModelCopyWith<$Res>(_value.product, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CartModelCopyWith<$Res> implements $CartModelCopyWith<$Res> {
  factory _$$_CartModelCopyWith(
          _$_CartModel value, $Res Function(_$_CartModel) then) =
      __$$_CartModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ProductModel product,
      int product_detail_id,
      int price,
      int? sale_price,
      int quantity,
      String color,
      String size,
      String photo,
      DateTime created_at});

  @override
  $ProductModelCopyWith<$Res> get product;
}

/// @nodoc
class __$$_CartModelCopyWithImpl<$Res>
    extends _$CartModelCopyWithImpl<$Res, _$_CartModel>
    implements _$$_CartModelCopyWith<$Res> {
  __$$_CartModelCopyWithImpl(
      _$_CartModel _value, $Res Function(_$_CartModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = null,
    Object? product_detail_id = null,
    Object? price = null,
    Object? sale_price = freezed,
    Object? quantity = null,
    Object? color = null,
    Object? size = null,
    Object? photo = null,
    Object? created_at = null,
  }) {
    return _then(_$_CartModel(
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductModel,
      product_detail_id: null == product_detail_id
          ? _value.product_detail_id
          : product_detail_id // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      sale_price: freezed == sale_price
          ? _value.sale_price
          : sale_price // ignore: cast_nullable_to_non_nullable
              as int?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String,
      photo: null == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_CartModel implements _CartModel {
  const _$_CartModel(
      {required this.product,
      required this.product_detail_id,
      required this.price,
      required this.sale_price,
      required this.quantity,
      required this.color,
      required this.size,
      required this.photo,
      required this.created_at});

  factory _$_CartModel.fromJson(Map<String, dynamic> json) =>
      _$$_CartModelFromJson(json);

  @override
  final ProductModel product;
  @override
  final int product_detail_id;
  @override
  final int price;
  @override
  final int? sale_price;
  @override
  final int quantity;
  @override
  final String color;
  @override
  final String size;
  @override
  final String photo;
  @override
  final DateTime created_at;

  @override
  String toString() {
    return 'CartModel(product: $product, product_detail_id: $product_detail_id, price: $price, sale_price: $sale_price, quantity: $quantity, color: $color, size: $size, photo: $photo, created_at: $created_at)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CartModel &&
            (identical(other.product, product) || other.product == product) &&
            (identical(other.product_detail_id, product_detail_id) ||
                other.product_detail_id == product_detail_id) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.sale_price, sale_price) ||
                other.sale_price == sale_price) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.photo, photo) || other.photo == photo) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, product, product_detail_id,
      price, sale_price, quantity, color, size, photo, created_at);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CartModelCopyWith<_$_CartModel> get copyWith =>
      __$$_CartModelCopyWithImpl<_$_CartModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CartModelToJson(
      this,
    );
  }
}

abstract class _CartModel implements CartModel {
  const factory _CartModel(
      {required final ProductModel product,
      required final int product_detail_id,
      required final int price,
      required final int? sale_price,
      required final int quantity,
      required final String color,
      required final String size,
      required final String photo,
      required final DateTime created_at}) = _$_CartModel;

  factory _CartModel.fromJson(Map<String, dynamic> json) =
      _$_CartModel.fromJson;

  @override
  ProductModel get product;
  @override
  int get product_detail_id;
  @override
  int get price;
  @override
  int? get sale_price;
  @override
  int get quantity;
  @override
  String get color;
  @override
  String get size;
  @override
  String get photo;
  @override
  DateTime get created_at;
  @override
  @JsonKey(ignore: true)
  _$$_CartModelCopyWith<_$_CartModel> get copyWith =>
      throw _privateConstructorUsedError;
}
