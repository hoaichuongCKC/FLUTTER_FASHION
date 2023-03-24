// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return _ProductModel.fromJson(json);
}

/// @nodoc
mixin _$ProductModel {
  int? get id => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  int? get regular_price => throw _privateConstructorUsedError;
  double? get discount => throw _privateConstructorUsedError;
  int? get sale_price => throw _privateConstructorUsedError;
  Properties? get properties => throw _privateConstructorUsedError;
  String? get desc => throw _privateConstructorUsedError;
  int? get view => throw _privateConstructorUsedError;
  double? get star => throw _privateConstructorUsedError;
  int? get sold => throw _privateConstructorUsedError;
  bool? get is_popular => throw _privateConstructorUsedError;
  Category? get category => throw _privateConstructorUsedError;
  List<PhotoModel>? get product_detail => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductModelCopyWith<ProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductModelCopyWith<$Res> {
  factory $ProductModelCopyWith(
          ProductModel value, $Res Function(ProductModel) then) =
      _$ProductModelCopyWithImpl<$Res, ProductModel>;
  @useResult
  $Res call(
      {int? id,
      String? code,
      String? name,
      int? regular_price,
      double? discount,
      int? sale_price,
      Properties? properties,
      String? desc,
      int? view,
      double? star,
      int? sold,
      bool? is_popular,
      Category? category,
      List<PhotoModel>? product_detail});

  $PropertiesCopyWith<$Res>? get properties;
  $CategoryCopyWith<$Res>? get category;
}

/// @nodoc
class _$ProductModelCopyWithImpl<$Res, $Val extends ProductModel>
    implements $ProductModelCopyWith<$Res> {
  _$ProductModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? code = freezed,
    Object? name = freezed,
    Object? regular_price = freezed,
    Object? discount = freezed,
    Object? sale_price = freezed,
    Object? properties = freezed,
    Object? desc = freezed,
    Object? view = freezed,
    Object? star = freezed,
    Object? sold = freezed,
    Object? is_popular = freezed,
    Object? category = freezed,
    Object? product_detail = freezed,
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
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      regular_price: freezed == regular_price
          ? _value.regular_price
          : regular_price // ignore: cast_nullable_to_non_nullable
              as int?,
      discount: freezed == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double?,
      sale_price: freezed == sale_price
          ? _value.sale_price
          : sale_price // ignore: cast_nullable_to_non_nullable
              as int?,
      properties: freezed == properties
          ? _value.properties
          : properties // ignore: cast_nullable_to_non_nullable
              as Properties?,
      desc: freezed == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String?,
      view: freezed == view
          ? _value.view
          : view // ignore: cast_nullable_to_non_nullable
              as int?,
      star: freezed == star
          ? _value.star
          : star // ignore: cast_nullable_to_non_nullable
              as double?,
      sold: freezed == sold
          ? _value.sold
          : sold // ignore: cast_nullable_to_non_nullable
              as int?,
      is_popular: freezed == is_popular
          ? _value.is_popular
          : is_popular // ignore: cast_nullable_to_non_nullable
              as bool?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      product_detail: freezed == product_detail
          ? _value.product_detail
          : product_detail // ignore: cast_nullable_to_non_nullable
              as List<PhotoModel>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PropertiesCopyWith<$Res>? get properties {
    if (_value.properties == null) {
      return null;
    }

    return $PropertiesCopyWith<$Res>(_value.properties!, (value) {
      return _then(_value.copyWith(properties: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CategoryCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $CategoryCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ProductModelCopyWith<$Res>
    implements $ProductModelCopyWith<$Res> {
  factory _$$_ProductModelCopyWith(
          _$_ProductModel value, $Res Function(_$_ProductModel) then) =
      __$$_ProductModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? code,
      String? name,
      int? regular_price,
      double? discount,
      int? sale_price,
      Properties? properties,
      String? desc,
      int? view,
      double? star,
      int? sold,
      bool? is_popular,
      Category? category,
      List<PhotoModel>? product_detail});

  @override
  $PropertiesCopyWith<$Res>? get properties;
  @override
  $CategoryCopyWith<$Res>? get category;
}

/// @nodoc
class __$$_ProductModelCopyWithImpl<$Res>
    extends _$ProductModelCopyWithImpl<$Res, _$_ProductModel>
    implements _$$_ProductModelCopyWith<$Res> {
  __$$_ProductModelCopyWithImpl(
      _$_ProductModel _value, $Res Function(_$_ProductModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? code = freezed,
    Object? name = freezed,
    Object? regular_price = freezed,
    Object? discount = freezed,
    Object? sale_price = freezed,
    Object? properties = freezed,
    Object? desc = freezed,
    Object? view = freezed,
    Object? star = freezed,
    Object? sold = freezed,
    Object? is_popular = freezed,
    Object? category = freezed,
    Object? product_detail = freezed,
  }) {
    return _then(_$_ProductModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      regular_price: freezed == regular_price
          ? _value.regular_price
          : regular_price // ignore: cast_nullable_to_non_nullable
              as int?,
      discount: freezed == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double?,
      sale_price: freezed == sale_price
          ? _value.sale_price
          : sale_price // ignore: cast_nullable_to_non_nullable
              as int?,
      properties: freezed == properties
          ? _value.properties
          : properties // ignore: cast_nullable_to_non_nullable
              as Properties?,
      desc: freezed == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String?,
      view: freezed == view
          ? _value.view
          : view // ignore: cast_nullable_to_non_nullable
              as int?,
      star: freezed == star
          ? _value.star
          : star // ignore: cast_nullable_to_non_nullable
              as double?,
      sold: freezed == sold
          ? _value.sold
          : sold // ignore: cast_nullable_to_non_nullable
              as int?,
      is_popular: freezed == is_popular
          ? _value.is_popular
          : is_popular // ignore: cast_nullable_to_non_nullable
              as bool?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      product_detail: freezed == product_detail
          ? _value._product_detail
          : product_detail // ignore: cast_nullable_to_non_nullable
              as List<PhotoModel>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_ProductModel implements _ProductModel {
  const _$_ProductModel(
      {this.id,
      this.code,
      this.name,
      this.regular_price,
      this.discount,
      this.sale_price,
      this.properties,
      this.desc,
      this.view,
      this.star,
      this.sold,
      this.is_popular,
      this.category,
      final List<PhotoModel>? product_detail})
      : _product_detail = product_detail;

  factory _$_ProductModel.fromJson(Map<String, dynamic> json) =>
      _$$_ProductModelFromJson(json);

  @override
  final int? id;
  @override
  final String? code;
  @override
  final String? name;
  @override
  final int? regular_price;
  @override
  final double? discount;
  @override
  final int? sale_price;
  @override
  final Properties? properties;
  @override
  final String? desc;
  @override
  final int? view;
  @override
  final double? star;
  @override
  final int? sold;
  @override
  final bool? is_popular;
  @override
  final Category? category;
  final List<PhotoModel>? _product_detail;
  @override
  List<PhotoModel>? get product_detail {
    final value = _product_detail;
    if (value == null) return null;
    if (_product_detail is EqualUnmodifiableListView) return _product_detail;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ProductModel(id: $id, code: $code, name: $name, regular_price: $regular_price, discount: $discount, sale_price: $sale_price, properties: $properties, desc: $desc, view: $view, star: $star, sold: $sold, is_popular: $is_popular, category: $category, product_detail: $product_detail)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProductModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.regular_price, regular_price) ||
                other.regular_price == regular_price) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.sale_price, sale_price) ||
                other.sale_price == sale_price) &&
            (identical(other.properties, properties) ||
                other.properties == properties) &&
            (identical(other.desc, desc) || other.desc == desc) &&
            (identical(other.view, view) || other.view == view) &&
            (identical(other.star, star) || other.star == star) &&
            (identical(other.sold, sold) || other.sold == sold) &&
            (identical(other.is_popular, is_popular) ||
                other.is_popular == is_popular) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality()
                .equals(other._product_detail, _product_detail));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      code,
      name,
      regular_price,
      discount,
      sale_price,
      properties,
      desc,
      view,
      star,
      sold,
      is_popular,
      category,
      const DeepCollectionEquality().hash(_product_detail));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProductModelCopyWith<_$_ProductModel> get copyWith =>
      __$$_ProductModelCopyWithImpl<_$_ProductModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProductModelToJson(
      this,
    );
  }
}

abstract class _ProductModel implements ProductModel {
  const factory _ProductModel(
      {final int? id,
      final String? code,
      final String? name,
      final int? regular_price,
      final double? discount,
      final int? sale_price,
      final Properties? properties,
      final String? desc,
      final int? view,
      final double? star,
      final int? sold,
      final bool? is_popular,
      final Category? category,
      final List<PhotoModel>? product_detail}) = _$_ProductModel;

  factory _ProductModel.fromJson(Map<String, dynamic> json) =
      _$_ProductModel.fromJson;

  @override
  int? get id;
  @override
  String? get code;
  @override
  String? get name;
  @override
  int? get regular_price;
  @override
  double? get discount;
  @override
  int? get sale_price;
  @override
  Properties? get properties;
  @override
  String? get desc;
  @override
  int? get view;
  @override
  double? get star;
  @override
  int? get sold;
  @override
  bool? get is_popular;
  @override
  Category? get category;
  @override
  List<PhotoModel>? get product_detail;
  @override
  @JsonKey(ignore: true)
  _$$_ProductModelCopyWith<_$_ProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return _Category.fromJson(json);
}

/// @nodoc
mixin _$Category {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get name_vi => throw _privateConstructorUsedError;
  String get photo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CategoryCopyWith<Category> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryCopyWith<$Res> {
  factory $CategoryCopyWith(Category value, $Res Function(Category) then) =
      _$CategoryCopyWithImpl<$Res, Category>;
  @useResult
  $Res call({int id, String name, String name_vi, String photo});
}

/// @nodoc
class _$CategoryCopyWithImpl<$Res, $Val extends Category>
    implements $CategoryCopyWith<$Res> {
  _$CategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? name_vi = null,
    Object? photo = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      name_vi: null == name_vi
          ? _value.name_vi
          : name_vi // ignore: cast_nullable_to_non_nullable
              as String,
      photo: null == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CategoryCopyWith<$Res> implements $CategoryCopyWith<$Res> {
  factory _$$_CategoryCopyWith(
          _$_Category value, $Res Function(_$_Category) then) =
      __$$_CategoryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String name_vi, String photo});
}

/// @nodoc
class __$$_CategoryCopyWithImpl<$Res>
    extends _$CategoryCopyWithImpl<$Res, _$_Category>
    implements _$$_CategoryCopyWith<$Res> {
  __$$_CategoryCopyWithImpl(
      _$_Category _value, $Res Function(_$_Category) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? name_vi = null,
    Object? photo = null,
  }) {
    return _then(_$_Category(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      name_vi: null == name_vi
          ? _value.name_vi
          : name_vi // ignore: cast_nullable_to_non_nullable
              as String,
      photo: null == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Category implements _Category {
  const _$_Category(
      {required this.id,
      required this.name,
      required this.name_vi,
      required this.photo});

  factory _$_Category.fromJson(Map<String, dynamic> json) =>
      _$$_CategoryFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String name_vi;
  @override
  final String photo;

  @override
  String toString() {
    return 'Category(id: $id, name: $name, name_vi: $name_vi, photo: $photo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Category &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.name_vi, name_vi) || other.name_vi == name_vi) &&
            (identical(other.photo, photo) || other.photo == photo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, name_vi, photo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CategoryCopyWith<_$_Category> get copyWith =>
      __$$_CategoryCopyWithImpl<_$_Category>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CategoryToJson(
      this,
    );
  }
}

abstract class _Category implements Category {
  const factory _Category(
      {required final int id,
      required final String name,
      required final String name_vi,
      required final String photo}) = _$_Category;

  factory _Category.fromJson(Map<String, dynamic> json) = _$_Category.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get name_vi;
  @override
  String get photo;
  @override
  @JsonKey(ignore: true)
  _$$_CategoryCopyWith<_$_Category> get copyWith =>
      throw _privateConstructorUsedError;
}

Properties _$PropertiesFromJson(Map<String, dynamic> json) {
  return _Properties.fromJson(json);
}

/// @nodoc
mixin _$Properties {
  List<dynamic>? get sizes => throw _privateConstructorUsedError;
  String? get origin => throw _privateConstructorUsedError;
  List<String>? get colors => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PropertiesCopyWith<Properties> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PropertiesCopyWith<$Res> {
  factory $PropertiesCopyWith(
          Properties value, $Res Function(Properties) then) =
      _$PropertiesCopyWithImpl<$Res, Properties>;
  @useResult
  $Res call({List<dynamic>? sizes, String? origin, List<String>? colors});
}

/// @nodoc
class _$PropertiesCopyWithImpl<$Res, $Val extends Properties>
    implements $PropertiesCopyWith<$Res> {
  _$PropertiesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sizes = freezed,
    Object? origin = freezed,
    Object? colors = freezed,
  }) {
    return _then(_value.copyWith(
      sizes: freezed == sizes
          ? _value.sizes
          : sizes // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      origin: freezed == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as String?,
      colors: freezed == colors
          ? _value.colors
          : colors // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PropertiesCopyWith<$Res>
    implements $PropertiesCopyWith<$Res> {
  factory _$$_PropertiesCopyWith(
          _$_Properties value, $Res Function(_$_Properties) then) =
      __$$_PropertiesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<dynamic>? sizes, String? origin, List<String>? colors});
}

/// @nodoc
class __$$_PropertiesCopyWithImpl<$Res>
    extends _$PropertiesCopyWithImpl<$Res, _$_Properties>
    implements _$$_PropertiesCopyWith<$Res> {
  __$$_PropertiesCopyWithImpl(
      _$_Properties _value, $Res Function(_$_Properties) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sizes = freezed,
    Object? origin = freezed,
    Object? colors = freezed,
  }) {
    return _then(_$_Properties(
      sizes: freezed == sizes
          ? _value._sizes
          : sizes // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      origin: freezed == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as String?,
      colors: freezed == colors
          ? _value._colors
          : colors // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Properties implements _Properties {
  const _$_Properties(
      {final List<dynamic>? sizes, this.origin, final List<String>? colors})
      : _sizes = sizes,
        _colors = colors;

  factory _$_Properties.fromJson(Map<String, dynamic> json) =>
      _$$_PropertiesFromJson(json);

  final List<dynamic>? _sizes;
  @override
  List<dynamic>? get sizes {
    final value = _sizes;
    if (value == null) return null;
    if (_sizes is EqualUnmodifiableListView) return _sizes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? origin;
  final List<String>? _colors;
  @override
  List<String>? get colors {
    final value = _colors;
    if (value == null) return null;
    if (_colors is EqualUnmodifiableListView) return _colors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Properties(sizes: $sizes, origin: $origin, colors: $colors)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Properties &&
            const DeepCollectionEquality().equals(other._sizes, _sizes) &&
            (identical(other.origin, origin) || other.origin == origin) &&
            const DeepCollectionEquality().equals(other._colors, _colors));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_sizes),
      origin,
      const DeepCollectionEquality().hash(_colors));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PropertiesCopyWith<_$_Properties> get copyWith =>
      __$$_PropertiesCopyWithImpl<_$_Properties>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PropertiesToJson(
      this,
    );
  }
}

abstract class _Properties implements Properties {
  const factory _Properties(
      {final List<dynamic>? sizes,
      final String? origin,
      final List<String>? colors}) = _$_Properties;

  factory _Properties.fromJson(Map<String, dynamic> json) =
      _$_Properties.fromJson;

  @override
  List<dynamic>? get sizes;
  @override
  String? get origin;
  @override
  List<String>? get colors;
  @override
  @JsonKey(ignore: true)
  _$$_PropertiesCopyWith<_$_Properties> get copyWith =>
      throw _privateConstructorUsedError;
}
