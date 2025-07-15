// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Document _$DocumentFromJson(Map<String, dynamic> json) => _Document(
  id: json['id'] as String,
  filename: json['filename'] as String,
  originalFilename: json['original_filename'] as String?,
  author: json['author'] as String?,
  pageCount: (json['page_count'] as num?)?.toInt(),
  fileSize: (json['file_size'] as num?)?.toInt(),
  fileExtension: json['file_extension'] as String?,
  chunkCount: (json['chunk_count'] as num).toInt(),
  addedAt: json['added_at'] == null
      ? null
      : DateTime.parse(json['added_at'] as String),
  ingestedAt: json['ingested_at'] == null
      ? null
      : DateTime.parse(json['ingested_at'] as String),
  thumbnailUrl: json['thumbnail_url'] as String?,
);

Map<String, dynamic> _$DocumentToJson(_Document instance) => <String, dynamic>{
  'id': instance.id,
  'filename': instance.filename,
  'original_filename': instance.originalFilename,
  'author': instance.author,
  'page_count': instance.pageCount,
  'file_size': instance.fileSize,
  'file_extension': instance.fileExtension,
  'chunk_count': instance.chunkCount,
  'added_at': instance.addedAt?.toIso8601String(),
  'ingested_at': instance.ingestedAt?.toIso8601String(),
  'thumbnail_url': instance.thumbnailUrl,
};
