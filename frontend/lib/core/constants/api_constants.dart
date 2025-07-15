class ApiConstants {
  static const String baseUrl = 'http://localhost:8000';
  static const String documentsEndpoint = '/documents';
  static const String ingestEndpoint = '/ingest';
  static const String chatEndpoint =
      '/chat'; // Base path for chat, ID will be appended
  static const String healthEndpoint = '/health';

  // Request timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 60);
}
