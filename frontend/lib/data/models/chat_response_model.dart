// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_response_model.freezed.dart';
part 'chat_response_model.g.dart';

@freezed
abstract class ChatResponseModel with _$ChatResponseModel {
  const factory ChatResponseModel({
    required String response,
    @JsonKey(name: 'conversation_id') required String conversationId,
  }) = _ChatResponseModel;

  factory ChatResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ChatResponseModelFromJson(json);
}
