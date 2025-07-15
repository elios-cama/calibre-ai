import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import '../../core/constants/api_constants.dart';
import '../models/chat_request_model.dart';
import '../models/chat_response_model.dart';
import '../../domain/entities/document.dart';

class ChatRemoteDataSource {
  final Dio dio;

  ChatRemoteDataSource({required this.dio});

  Future<List<Document>> getDocuments() async {
    try {
      final response = await dio.get(ApiConstants.documentsEndpoint);
      if (response.statusCode == 200) {
        final documents = (response.data as List)
            .map((doc) => Document.fromJson(doc))
            .toList();
        return documents;
      } else {
        throw Exception('Failed to load documents');
      }
    } catch (e) {
      throw Exception('Failed to load documents: $e');
    }
  }

  Future<void> ingestDocument() async {
    try {
      // For desktop, we read the file path, not the bytes
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.single.path != null) {
        final filePath = result.files.single.path!;
        final fileName = result.files.single.name;

        final formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(filePath, filename: fileName),
        });
        await dio.post(ApiConstants.ingestEndpoint, data: formData);
      }
    } catch (e) {
      throw Exception('Failed to ingest document: $e');
    }
  }

  Future<ChatResponseModel> sendMessage(ChatRequestModel request) async {
    try {
      // The conversationId from the request is the documentId
      if (request.conversationId == null) {
        throw Exception("Document ID cannot be null");
      }
      final response = await dio.post(
        '${ApiConstants.chatEndpoint}/${request.conversationId}',
        data: {'prompt': request.query},
      );
      if (response.statusCode == 200) {
        return ChatResponseModel(
          response: response.data['response'],
          conversationId: request.conversationId!,
        );
      } else {
        throw Exception('Failed to get chat response');
      }
    } catch (e) {
      throw Exception('Failed to get chat response: $e');
    }
  }
}
