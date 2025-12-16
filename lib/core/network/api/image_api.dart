import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ImageApi {
  static String get _baseUrl => dotenv.env['BASE_URL'] ?? '';

  Future<String?> uploadImage(File file, {String field = 'file'}) async {
    try {
      final uri = Uri.parse('$_baseUrl/api/v1/images/upload');
      final request = http.MultipartRequest('POST', uri);
      final multipartFile = await http.MultipartFile.fromPath(field, file.path);
      request.files.add(multipartFile);
      final streamed = await request.send().timeout(Duration(seconds: 30));
      final resp = await http.Response.fromStream(streamed);
      if (resp.statusCode < 200 || resp.statusCode >= 300) {
        return null;
      }
      final body = resp.body;
      try {
        final parsed = jsonDecode(body);
        if (parsed is Map<String, dynamic>) {
          if (parsed.containsKey('id')) return parsed['id'].toString();
          if (parsed.containsKey('data')) {
            final d = parsed['data'];
            if (d is String) return d;
            if (d is Map && d['id'] != null) return d['id'].toString();
            if (d is Map && d['url'] != null) return d['url'].toString();
          }
          if (parsed.containsKey('url')) return parsed['url'].toString();
        }
      } catch (_) {}
      return body;
    } on SocketException {
      print('ImageApi.uploadImage SocketException connecting to $_baseUrl');
      return null;
    } on http.ClientException {
      print('ImageApi.uploadImage ClientException');
      return null;
    } on Exception {
      print('ImageApi.uploadImage unknown exception');
      return null;
    }
  }
}

