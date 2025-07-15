// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatResponseModel {

 String get response;@JsonKey(name: 'conversation_id') String get conversationId;
/// Create a copy of ChatResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatResponseModelCopyWith<ChatResponseModel> get copyWith => _$ChatResponseModelCopyWithImpl<ChatResponseModel>(this as ChatResponseModel, _$identity);

  /// Serializes this ChatResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatResponseModel&&(identical(other.response, response) || other.response == response)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,response,conversationId);

@override
String toString() {
  return 'ChatResponseModel(response: $response, conversationId: $conversationId)';
}


}

/// @nodoc
abstract mixin class $ChatResponseModelCopyWith<$Res>  {
  factory $ChatResponseModelCopyWith(ChatResponseModel value, $Res Function(ChatResponseModel) _then) = _$ChatResponseModelCopyWithImpl;
@useResult
$Res call({
 String response,@JsonKey(name: 'conversation_id') String conversationId
});




}
/// @nodoc
class _$ChatResponseModelCopyWithImpl<$Res>
    implements $ChatResponseModelCopyWith<$Res> {
  _$ChatResponseModelCopyWithImpl(this._self, this._then);

  final ChatResponseModel _self;
  final $Res Function(ChatResponseModel) _then;

/// Create a copy of ChatResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? response = null,Object? conversationId = null,}) {
  return _then(_self.copyWith(
response: null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as String,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatResponseModel].
extension ChatResponseModelPatterns on ChatResponseModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatResponseModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatResponseModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatResponseModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String response, @JsonKey(name: 'conversation_id')  String conversationId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatResponseModel() when $default != null:
return $default(_that.response,_that.conversationId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String response, @JsonKey(name: 'conversation_id')  String conversationId)  $default,) {final _that = this;
switch (_that) {
case _ChatResponseModel():
return $default(_that.response,_that.conversationId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String response, @JsonKey(name: 'conversation_id')  String conversationId)?  $default,) {final _that = this;
switch (_that) {
case _ChatResponseModel() when $default != null:
return $default(_that.response,_that.conversationId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatResponseModel implements ChatResponseModel {
  const _ChatResponseModel({required this.response, @JsonKey(name: 'conversation_id') required this.conversationId});
  factory _ChatResponseModel.fromJson(Map<String, dynamic> json) => _$ChatResponseModelFromJson(json);

@override final  String response;
@override@JsonKey(name: 'conversation_id') final  String conversationId;

/// Create a copy of ChatResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatResponseModelCopyWith<_ChatResponseModel> get copyWith => __$ChatResponseModelCopyWithImpl<_ChatResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatResponseModel&&(identical(other.response, response) || other.response == response)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,response,conversationId);

@override
String toString() {
  return 'ChatResponseModel(response: $response, conversationId: $conversationId)';
}


}

/// @nodoc
abstract mixin class _$ChatResponseModelCopyWith<$Res> implements $ChatResponseModelCopyWith<$Res> {
  factory _$ChatResponseModelCopyWith(_ChatResponseModel value, $Res Function(_ChatResponseModel) _then) = __$ChatResponseModelCopyWithImpl;
@override @useResult
$Res call({
 String response,@JsonKey(name: 'conversation_id') String conversationId
});




}
/// @nodoc
class __$ChatResponseModelCopyWithImpl<$Res>
    implements _$ChatResponseModelCopyWith<$Res> {
  __$ChatResponseModelCopyWithImpl(this._self, this._then);

  final _ChatResponseModel _self;
  final $Res Function(_ChatResponseModel) _then;

/// Create a copy of ChatResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? response = null,Object? conversationId = null,}) {
  return _then(_ChatResponseModel(
response: null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as String,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
