// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatResponseModel _$ChatResponseModelFromJson(Map<String, dynamic> json) =>
    _ChatResponseModel(
      response: json['response'] as String,
      conversationId: json['conversation_id'] as String,
    );

Map<String, dynamic> _$ChatResponseModelToJson(_ChatResponseModel instance) =>
    <String, dynamic>{
      'response': instance.response,
      'conversation_id': instance.conversationId,
    };
