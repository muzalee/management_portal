import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:management_portal/domain/entities/comment.dart';

class CommentRepository {
  final String _baseUrl = "https://jsonplaceholder.typicode.com";
  final http.Client _httpClient;

  CommentRepository({required http.Client httpClient}) : _httpClient = httpClient;

  Future<List<Comment>> getComments(int id) async {
    try {
      final response = await _httpClient.get(Uri.parse("$_baseUrl/posts/$id/comments"));
      if (response.statusCode == 200) {
        final List<dynamic> postsJson = jsonDecode(response.body);
        return postsJson.map((json) => Comment.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load comments");
      }
    } catch (e) {
      log("Failed to load comments: ${e.toString()}");
      throw Exception("Failed to load comments: ${e.toString()}");
    }
  }
}