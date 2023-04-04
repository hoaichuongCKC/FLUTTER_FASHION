// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) {
  return _ChatModel.fromJson(json);
}

/// @nodoc
mixin _$ChatModel {
  int get id => throw _privateConstructorUsedError;
  int get room_chat_id => throw _privateConstructorUsedError;
  int get sender_id => throw _privateConstructorUsedError;
  int get receiver_id => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  DateTime get created_at => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatModelCopyWith<ChatModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatModelCopyWith<$Res> {
  factory $ChatModelCopyWith(ChatModel value, $Res Function(ChatModel) then) =
      _$ChatModelCopyWithImpl<$Res, ChatModel>;
  @useResult
  $Res call(
      {int id,
      int room_chat_id,
      int sender_id,
      int receiver_id,
      String message,
      DateTime created_at});
}

/// @nodoc
class _$ChatModelCopyWithImpl<$Res, $Val extends ChatModel>
    implements $ChatModelCopyWith<$Res> {
  _$ChatModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? room_chat_id = null,
    Object? sender_id = null,
    Object? receiver_id = null,
    Object? message = null,
    Object? created_at = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      room_chat_id: null == room_chat_id
          ? _value.room_chat_id
          : room_chat_id // ignore: cast_nullable_to_non_nullable
              as int,
      sender_id: null == sender_id
          ? _value.sender_id
          : sender_id // ignore: cast_nullable_to_non_nullable
              as int,
      receiver_id: null == receiver_id
          ? _value.receiver_id
          : receiver_id // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChatModelCopyWith<$Res> implements $ChatModelCopyWith<$Res> {
  factory _$$_ChatModelCopyWith(
          _$_ChatModel value, $Res Function(_$_ChatModel) then) =
      __$$_ChatModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int room_chat_id,
      int sender_id,
      int receiver_id,
      String message,
      DateTime created_at});
}

/// @nodoc
class __$$_ChatModelCopyWithImpl<$Res>
    extends _$ChatModelCopyWithImpl<$Res, _$_ChatModel>
    implements _$$_ChatModelCopyWith<$Res> {
  __$$_ChatModelCopyWithImpl(
      _$_ChatModel _value, $Res Function(_$_ChatModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? room_chat_id = null,
    Object? sender_id = null,
    Object? receiver_id = null,
    Object? message = null,
    Object? created_at = null,
  }) {
    return _then(_$_ChatModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      room_chat_id: null == room_chat_id
          ? _value.room_chat_id
          : room_chat_id // ignore: cast_nullable_to_non_nullable
              as int,
      sender_id: null == sender_id
          ? _value.sender_id
          : sender_id // ignore: cast_nullable_to_non_nullable
              as int,
      receiver_id: null == receiver_id
          ? _value.receiver_id
          : receiver_id // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
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
class _$_ChatModel implements _ChatModel {
  const _$_ChatModel(
      {required this.id,
      required this.room_chat_id,
      required this.sender_id,
      required this.receiver_id,
      required this.message,
      required this.created_at});

  factory _$_ChatModel.fromJson(Map<String, dynamic> json) =>
      _$$_ChatModelFromJson(json);

  @override
  final int id;
  @override
  final int room_chat_id;
  @override
  final int sender_id;
  @override
  final int receiver_id;
  @override
  final String message;
  @override
  final DateTime created_at;

  @override
  String toString() {
    return 'ChatModel(id: $id, room_chat_id: $room_chat_id, sender_id: $sender_id, receiver_id: $receiver_id, message: $message, created_at: $created_at)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.room_chat_id, room_chat_id) ||
                other.room_chat_id == room_chat_id) &&
            (identical(other.sender_id, sender_id) ||
                other.sender_id == sender_id) &&
            (identical(other.receiver_id, receiver_id) ||
                other.receiver_id == receiver_id) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, room_chat_id, sender_id,
      receiver_id, message, created_at);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatModelCopyWith<_$_ChatModel> get copyWith =>
      __$$_ChatModelCopyWithImpl<_$_ChatModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatModelToJson(
      this,
    );
  }
}

abstract class _ChatModel implements ChatModel {
  const factory _ChatModel(
      {required final int id,
      required final int room_chat_id,
      required final int sender_id,
      required final int receiver_id,
      required final String message,
      required final DateTime created_at}) = _$_ChatModel;

  factory _ChatModel.fromJson(Map<String, dynamic> json) =
      _$_ChatModel.fromJson;

  @override
  int get id;
  @override
  int get room_chat_id;
  @override
  int get sender_id;
  @override
  int get receiver_id;
  @override
  String get message;
  @override
  DateTime get created_at;
  @override
  @JsonKey(ignore: true)
  _$$_ChatModelCopyWith<_$_ChatModel> get copyWith =>
      throw _privateConstructorUsedError;
}
