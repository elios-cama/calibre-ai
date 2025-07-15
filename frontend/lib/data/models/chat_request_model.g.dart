// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatRequestModel _$ChatRequestModelFromJson(Map<String, dynamic> json) =>
    _ChatRequestModel(
      query: json['query'] as String,
      agentType: json['agentType'] as String? ?? 'pdf_assistant',
      conversationId: json['conversationId'] as String?,
    );

Map<String, dynamic> _$ChatRequestModelToJson(_ChatRequestModel instance) =>
    <String, dynamic>{
      'query': instance.query,
      'agentType': instance.agentType,
      'conversationId': instance.conversationId,
    };
