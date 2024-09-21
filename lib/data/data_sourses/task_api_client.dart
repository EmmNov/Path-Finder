import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_finder/data/models/task.dart';

class TaskApiClient {
  final _client = http.Client();

  Future<List<TaskDto>> getData(String url) async {
    try {
      final uri = Uri.parse(url);
      final res = await _client.get(uri);

      if (res.statusCode != 200) {
        throw HttpException('Failed to load data', statusCode: res.statusCode);
      }
      final json = jsonDecode(res.body) as Map<String, dynamic>;
      if (json['error'] == true) {
        throw ApiException(
          json['message'] ?? 'Unknown API error',
        );
      }
      if (!json.containsKey('data')) {
        throw ApiException('Data not found in the response');
      }

      final tasks = json['data'] as List<dynamic>;

      return tasks
          .map((e) => TaskDto.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (e is FormatException) {
        throw Exception('Invalid response format: ${e.message}');
      } else if (e is ApiException || e is HttpException) {
        rethrow;
      } else {
        throw Exception('An unknown error occurred: $e');
      }
    }
  }

  Future<void> sendResultingData(
      String url, List<Map<String, dynamic>> body) async {
    try {
      final uri = Uri.parse(url);
      final strBody = jsonEncode(body);

      final res = await _client.post(
        uri,
        body: strBody,
        headers: {'Content-Type': 'application/json'},
      );

      if (res.statusCode != 200) {
        throw HttpException('Failed to send data', statusCode: res.statusCode);
      }

      final json = jsonDecode(res.body) as Map<String, dynamic>;

      if (json['error'] == true) {
        throw ApiException(
          json['message'] ?? 'Unknown API error',
        );
      }
    } catch (e) {
      if (e is FormatException) {
        throw Exception('Invalid response format: ${e.message}');
      } else if (e is ApiException || e is HttpException) {
        rethrow;
      } else {
        throw Exception('An unknown error occurred: $e');
      }
    }
  }
}

class ApiException implements Exception {
  final String message;

  ApiException(
    this.message,
  );

  @override
  String toString() => 'API Exception: $message ';
}

class HttpException implements Exception {
  final String message;
  final int statusCode;

  HttpException(this.message, {required this.statusCode});

  @override
  String toString() => 'HTTP Exception: $message (Status Code: $statusCode)';
}
