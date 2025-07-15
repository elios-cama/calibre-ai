import 'package:freezed_annotation/freezed_annotation.dart';

part 'document.freezed.dart';
part 'document.g.dart';

@freezed
abstract class Document with _$Document {
  const factory Document({
    required String id,
    required String filename,
    @JsonKey(name: 'original_filename') String? originalFilename,
    String? author,
    @JsonKey(name: 'page_count') int? pageCount,
    @JsonKey(name: 'file_size') int? fileSize,
    @JsonKey(name: 'file_extension') String? fileExtension,
    @JsonKey(name: 'chunk_count') required int chunkCount,
    @JsonKey(name: 'added_at') DateTime? addedAt,
    @JsonKey(name: 'ingested_at') DateTime? ingestedAt,
    @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
  }) = _Document;

  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);
}
