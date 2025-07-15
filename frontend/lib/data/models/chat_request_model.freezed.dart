// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatRequestModel {

 String get query;@JsonKey(name: 'agentType') String get agentType;@JsonKey(name: 'conversationId') String? get conversationId;
/// Create a copy of ChatRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatRequestModelCopyWith<ChatRequestModel> get copyWith => _$ChatRequestModelCopyWithImpl<ChatRequestModel>(this as ChatRequestModel, _$identity);

  /// Serializes this ChatRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatRequestModel&&(identical(other.query, query) || other.query == query)&&(identical(other.agentType, agentType) || other.agentType == agentType)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,query,agentType,conversationId);

@override
String toString() {
  return 'ChatRequestModel(query: $query, agentType: $agentType, conversationId: $conversationId)';
}


}

/// @nodoc
abstract mixin class $ChatRequestModelCopyWith<$Res>  {
  factory $ChatRequestModelCopyWith(ChatRequestModel value, $Res Function(ChatRequestModel) _then) = _$ChatRequestModelCopyWithImpl;
@useResult
$Res call({
 String query,@JsonKey(name: 'agentType') String agentType,@JsonKey(name: 'conversationId') String? conversationId
});




}
/// @nodoc
class _$ChatRequestModelCopyWithImpl<$Res>
    implements $ChatRequestModelCopyWith<$Res> {
  _$ChatRequestModelCopyWithImpl(this._self, this._then);

  final ChatRequestModel _self;
  final $Res Function(ChatRequestModel) _then;

/// Create a copy of ChatRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? agentType = null,Object? conversationId = freezed,}) {
  return _then(_self.copyWith(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,agentType: null == agentType ? _self.agentType : agentType // ignore: cast_nullable_to_non_nullable
as String,conversationId: freezed == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatRequestModel].
extension ChatRequestModelPatterns on ChatRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query, @JsonKey(name: 'agentType')  String agentType, @JsonKey(name: 'conversationId')  String? conversationId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatRequestModel() when $default != null:
return $default(_that.query,_that.agentType,_that.conversationId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query, @JsonKey(name: 'agentType')  String agentType, @JsonKey(name: 'conversationId')  String? conversationId)  $default,) {final _that = this;
switch (_that) {
case _ChatRequestModel():
return $default(_that.query,_that.agentType,_that.conversationId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query, @JsonKey(name: 'agentType')  String agentType, @JsonKey(name: 'conversationId')  String? conversationId)?  $default,) {final _that = this;
switch (_that) {
case _ChatRequestModel() when $default != null:
return $default(_that.query,_that.agentType,_that.conversationId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatRequestModel implements ChatRequestModel {
  const _ChatRequestModel({required this.query, @JsonKey(name: 'agentType') this.agentType = 'pdf_assistant', @JsonKey(name: 'conversationId') this.conversationId});
  factory _ChatRequestModel.fromJson(Map<String, dynamic> json) => _$ChatRequestModelFromJson(json);

@override final  String query;
@override@JsonKey(name: 'agentType') final  String agentType;
@override@JsonKey(name: 'conversationId') final  String? conversationId;

/// Create a copy of ChatRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatRequestModelCopyWith<_ChatRequestModel> get copyWith => __$ChatRequestModelCopyWithImpl<_ChatRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatRequestModel&&(identical(other.query, query) || other.query == query)&&(identical(other.agentType, agentType) || other.agentType == agentType)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,query,agentType,conversationId);

@override
String toString() {
  return 'ChatRequestModel(query: $query, agentType: $agentType, conversationId: $conversationId)';
}


}

/// @nodoc
abstract mixin class _$ChatRequestModelCopyWith<$Res> implements $ChatRequestModelCopyWith<$Res> {
  factory _$ChatRequestModelCopyWith(_ChatRequestModel value, $Res Function(_ChatRequestModel) _then) = __$ChatRequestModelCopyWithImpl;
@override @useResult
$Res call({
 String query,@JsonKey(name: 'agentType') String agentType,@JsonKey(name: 'conversationId') String? conversationId
});




}
/// @nodoc
class __$ChatRequestModelCopyWithImpl<$Res>
    implements _$ChatRequestModelCopyWith<$Res> {
  __$ChatRequestModelCopyWithImpl(this._self, this._then);

  final _ChatRequestModel _self;
  final $Res Function(_ChatRequestModel) _then;

/// Create a copy of ChatRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? agentType = null,Object? conversationId = freezed,}) {
  return _then(_ChatRequestModel(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,agentType: null == agentType ? _self.agentType : agentType // ignore: cast_nullable_to_non_nullable
as String,conversationId: freezed == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
