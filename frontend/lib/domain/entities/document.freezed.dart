// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Document {

 String get id; String get filename;@JsonKey(name: 'original_filename') String? get originalFilename; String? get author;@JsonKey(name: 'page_count') int? get pageCount;@JsonKey(name: 'file_size') int? get fileSize;@JsonKey(name: 'file_extension') String? get fileExtension;@JsonKey(name: 'chunk_count') int get chunkCount;@JsonKey(name: 'added_at') DateTime? get addedAt;@JsonKey(name: 'ingested_at') DateTime? get ingestedAt;@JsonKey(name: 'thumbnail_url') String? get thumbnailUrl;
/// Create a copy of Document
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentCopyWith<Document> get copyWith => _$DocumentCopyWithImpl<Document>(this as Document, _$identity);

  /// Serializes this Document to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Document&&(identical(other.id, id) || other.id == id)&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.originalFilename, originalFilename) || other.originalFilename == originalFilename)&&(identical(other.author, author) || other.author == author)&&(identical(other.pageCount, pageCount) || other.pageCount == pageCount)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.fileExtension, fileExtension) || other.fileExtension == fileExtension)&&(identical(other.chunkCount, chunkCount) || other.chunkCount == chunkCount)&&(identical(other.addedAt, addedAt) || other.addedAt == addedAt)&&(identical(other.ingestedAt, ingestedAt) || other.ingestedAt == ingestedAt)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,filename,originalFilename,author,pageCount,fileSize,fileExtension,chunkCount,addedAt,ingestedAt,thumbnailUrl);

@override
String toString() {
  return 'Document(id: $id, filename: $filename, originalFilename: $originalFilename, author: $author, pageCount: $pageCount, fileSize: $fileSize, fileExtension: $fileExtension, chunkCount: $chunkCount, addedAt: $addedAt, ingestedAt: $ingestedAt, thumbnailUrl: $thumbnailUrl)';
}


}

/// @nodoc
abstract mixin class $DocumentCopyWith<$Res>  {
  factory $DocumentCopyWith(Document value, $Res Function(Document) _then) = _$DocumentCopyWithImpl;
@useResult
$Res call({
 String id, String filename,@JsonKey(name: 'original_filename') String? originalFilename, String? author,@JsonKey(name: 'page_count') int? pageCount,@JsonKey(name: 'file_size') int? fileSize,@JsonKey(name: 'file_extension') String? fileExtension,@JsonKey(name: 'chunk_count') int chunkCount,@JsonKey(name: 'added_at') DateTime? addedAt,@JsonKey(name: 'ingested_at') DateTime? ingestedAt,@JsonKey(name: 'thumbnail_url') String? thumbnailUrl
});




}
/// @nodoc
class _$DocumentCopyWithImpl<$Res>
    implements $DocumentCopyWith<$Res> {
  _$DocumentCopyWithImpl(this._self, this._then);

  final Document _self;
  final $Res Function(Document) _then;

/// Create a copy of Document
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? filename = null,Object? originalFilename = freezed,Object? author = freezed,Object? pageCount = freezed,Object? fileSize = freezed,Object? fileExtension = freezed,Object? chunkCount = null,Object? addedAt = freezed,Object? ingestedAt = freezed,Object? thumbnailUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,filename: null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,originalFilename: freezed == originalFilename ? _self.originalFilename : originalFilename // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,pageCount: freezed == pageCount ? _self.pageCount : pageCount // ignore: cast_nullable_to_non_nullable
as int?,fileSize: freezed == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int?,fileExtension: freezed == fileExtension ? _self.fileExtension : fileExtension // ignore: cast_nullable_to_non_nullable
as String?,chunkCount: null == chunkCount ? _self.chunkCount : chunkCount // ignore: cast_nullable_to_non_nullable
as int,addedAt: freezed == addedAt ? _self.addedAt : addedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,ingestedAt: freezed == ingestedAt ? _self.ingestedAt : ingestedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Document].
extension DocumentPatterns on Document {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Document value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Document() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Document value)  $default,){
final _that = this;
switch (_that) {
case _Document():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Document value)?  $default,){
final _that = this;
switch (_that) {
case _Document() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String filename, @JsonKey(name: 'original_filename')  String? originalFilename,  String? author, @JsonKey(name: 'page_count')  int? pageCount, @JsonKey(name: 'file_size')  int? fileSize, @JsonKey(name: 'file_extension')  String? fileExtension, @JsonKey(name: 'chunk_count')  int chunkCount, @JsonKey(name: 'added_at')  DateTime? addedAt, @JsonKey(name: 'ingested_at')  DateTime? ingestedAt, @JsonKey(name: 'thumbnail_url')  String? thumbnailUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Document() when $default != null:
return $default(_that.id,_that.filename,_that.originalFilename,_that.author,_that.pageCount,_that.fileSize,_that.fileExtension,_that.chunkCount,_that.addedAt,_that.ingestedAt,_that.thumbnailUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String filename, @JsonKey(name: 'original_filename')  String? originalFilename,  String? author, @JsonKey(name: 'page_count')  int? pageCount, @JsonKey(name: 'file_size')  int? fileSize, @JsonKey(name: 'file_extension')  String? fileExtension, @JsonKey(name: 'chunk_count')  int chunkCount, @JsonKey(name: 'added_at')  DateTime? addedAt, @JsonKey(name: 'ingested_at')  DateTime? ingestedAt, @JsonKey(name: 'thumbnail_url')  String? thumbnailUrl)  $default,) {final _that = this;
switch (_that) {
case _Document():
return $default(_that.id,_that.filename,_that.originalFilename,_that.author,_that.pageCount,_that.fileSize,_that.fileExtension,_that.chunkCount,_that.addedAt,_that.ingestedAt,_that.thumbnailUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String filename, @JsonKey(name: 'original_filename')  String? originalFilename,  String? author, @JsonKey(name: 'page_count')  int? pageCount, @JsonKey(name: 'file_size')  int? fileSize, @JsonKey(name: 'file_extension')  String? fileExtension, @JsonKey(name: 'chunk_count')  int chunkCount, @JsonKey(name: 'added_at')  DateTime? addedAt, @JsonKey(name: 'ingested_at')  DateTime? ingestedAt, @JsonKey(name: 'thumbnail_url')  String? thumbnailUrl)?  $default,) {final _that = this;
switch (_that) {
case _Document() when $default != null:
return $default(_that.id,_that.filename,_that.originalFilename,_that.author,_that.pageCount,_that.fileSize,_that.fileExtension,_that.chunkCount,_that.addedAt,_that.ingestedAt,_that.thumbnailUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Document implements Document {
  const _Document({required this.id, required this.filename, @JsonKey(name: 'original_filename') this.originalFilename, this.author, @JsonKey(name: 'page_count') this.pageCount, @JsonKey(name: 'file_size') this.fileSize, @JsonKey(name: 'file_extension') this.fileExtension, @JsonKey(name: 'chunk_count') required this.chunkCount, @JsonKey(name: 'added_at') this.addedAt, @JsonKey(name: 'ingested_at') this.ingestedAt, @JsonKey(name: 'thumbnail_url') this.thumbnailUrl});
  factory _Document.fromJson(Map<String, dynamic> json) => _$DocumentFromJson(json);

@override final  String id;
@override final  String filename;
@override@JsonKey(name: 'original_filename') final  String? originalFilename;
@override final  String? author;
@override@JsonKey(name: 'page_count') final  int? pageCount;
@override@JsonKey(name: 'file_size') final  int? fileSize;
@override@JsonKey(name: 'file_extension') final  String? fileExtension;
@override@JsonKey(name: 'chunk_count') final  int chunkCount;
@override@JsonKey(name: 'added_at') final  DateTime? addedAt;
@override@JsonKey(name: 'ingested_at') final  DateTime? ingestedAt;
@override@JsonKey(name: 'thumbnail_url') final  String? thumbnailUrl;

/// Create a copy of Document
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentCopyWith<_Document> get copyWith => __$DocumentCopyWithImpl<_Document>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Document&&(identical(other.id, id) || other.id == id)&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.originalFilename, originalFilename) || other.originalFilename == originalFilename)&&(identical(other.author, author) || other.author == author)&&(identical(other.pageCount, pageCount) || other.pageCount == pageCount)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.fileExtension, fileExtension) || other.fileExtension == fileExtension)&&(identical(other.chunkCount, chunkCount) || other.chunkCount == chunkCount)&&(identical(other.addedAt, addedAt) || other.addedAt == addedAt)&&(identical(other.ingestedAt, ingestedAt) || other.ingestedAt == ingestedAt)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,filename,originalFilename,author,pageCount,fileSize,fileExtension,chunkCount,addedAt,ingestedAt,thumbnailUrl);

@override
String toString() {
  return 'Document(id: $id, filename: $filename, originalFilename: $originalFilename, author: $author, pageCount: $pageCount, fileSize: $fileSize, fileExtension: $fileExtension, chunkCount: $chunkCount, addedAt: $addedAt, ingestedAt: $ingestedAt, thumbnailUrl: $thumbnailUrl)';
}


}

/// @nodoc
abstract mixin class _$DocumentCopyWith<$Res> implements $DocumentCopyWith<$Res> {
  factory _$DocumentCopyWith(_Document value, $Res Function(_Document) _then) = __$DocumentCopyWithImpl;
@override @useResult
$Res call({
 String id, String filename,@JsonKey(name: 'original_filename') String? originalFilename, String? author,@JsonKey(name: 'page_count') int? pageCount,@JsonKey(name: 'file_size') int? fileSize,@JsonKey(name: 'file_extension') String? fileExtension,@JsonKey(name: 'chunk_count') int chunkCount,@JsonKey(name: 'added_at') DateTime? addedAt,@JsonKey(name: 'ingested_at') DateTime? ingestedAt,@JsonKey(name: 'thumbnail_url') String? thumbnailUrl
});




}
/// @nodoc
class __$DocumentCopyWithImpl<$Res>
    implements _$DocumentCopyWith<$Res> {
  __$DocumentCopyWithImpl(this._self, this._then);

  final _Document _self;
  final $Res Function(_Document) _then;

/// Create a copy of Document
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? filename = null,Object? originalFilename = freezed,Object? author = freezed,Object? pageCount = freezed,Object? fileSize = freezed,Object? fileExtension = freezed,Object? chunkCount = null,Object? addedAt = freezed,Object? ingestedAt = freezed,Object? thumbnailUrl = freezed,}) {
  return _then(_Document(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,filename: null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,originalFilename: freezed == originalFilename ? _self.originalFilename : originalFilename // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,pageCount: freezed == pageCount ? _self.pageCount : pageCount // ignore: cast_nullable_to_non_nullable
as int?,fileSize: freezed == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int?,fileExtension: freezed == fileExtension ? _self.fileExtension : fileExtension // ignore: cast_nullable_to_non_nullable
as String?,chunkCount: null == chunkCount ? _self.chunkCount : chunkCount // ignore: cast_nullable_to_non_nullable
as int,addedAt: freezed == addedAt ? _self.addedAt : addedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,ingestedAt: freezed == ingestedAt ? _self.ingestedAt : ingestedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
