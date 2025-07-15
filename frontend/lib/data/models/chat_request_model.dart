// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_request_model.freezed.dart';
part 'chat_request_model.g.dart';

@freezed
abstract class ChatRequestModel with _$ChatRequestModel {
  const factory ChatRequestModel({
    required String query,
    @JsonKey(name: 'agentType') @Default('pdf_assistant') String agentType,
    @JsonKey(name: 'conversationId') String? conversationId,
  }) = _ChatRequestModel;

  factory ChatRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRequestModelFromJson(json);
}
