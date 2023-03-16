import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:management_portal/domain/entities/post.dart';

class PostRepository {
  final String _baseUrl = "https://jsonplaceholder.typicode.com";
  final http.Client _httpClient;

  PostRepository({required http.Client httpClient}) : _httpClient = httpClient;

  Future<List<Post>> getPosts(int page, int limit) async {
    try {
      final response = await _httpClient.get(Uri.parse("$_baseUrl/posts?_start=$page&_limit=$limit"));
      if (response.statusCode == 200) {
        final List<dynamic> postsJson = jsonDecode(response.body);
        return postsJson.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception("Get Post Error: ${response.statusCode}");
      }
    } catch (e) {
      log("Failed to load posts: ${e.toString()}");
      throw Exception("Failed to load posts: ${e.toString()}");
    }
  }

  Future<Post> getPost(int id) async {
    try {
      final response = await _httpClient.get(Uri.parse("$_baseUrl/posts/$id"));
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return Post.fromJson(json);
      } else {
        throw Exception("Get Post Detail Error: ${response.statusCode}");
      }
    } catch (e) {
      log("Failed to load post detail: ${e.toString()}");
      throw Exception("Failed to load post detail: ${e.toString()}");
    }
  }

  Future<void> deletePost(int id) async {
    try {
      final response = await _httpClient.delete(Uri.parse("$_baseUrl/posts/$id"));

      if (response.statusCode != 200) {
        throw Exception("Delete Post Error: ${response.statusCode}");
      }
    } catch (e) {
      log("Failed to delete post: ${e.toString()}");
      throw Exception("Failed to delete post: ${e.toString()}");
    }
  }

  Future<Post> createPost(String title, String body) async {
    try {
      final response = await _httpClient.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        body: json.encode({
          'title': title,
          'body': body,
          'userId': 1,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return Post.fromJson(json);
      } else {
        throw Exception("Create Post Error: ${response.statusCode}");
      }
    } catch (e) {
      log("Failed to create post: ${e.toString()}");
      throw Exception('Failed to create post: $e');
    }
  }

  Future<Post> updatePost(int id, String title, String body) async {
    try {
      final response = await _httpClient.put(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'),
        body: json.encode({
          'id': id,
          'title': title,
          'body': body,
          'userId': 1,
        }),
        headers: {'Content-type': 'application/json; charset=UTF-8'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return Post.fromJson(json);
      } else {
        throw Exception("Update Post Error: ${response.statusCode}");
      }
    } catch (e) {
      log("Failed to update post: ${e.toString()}");
      throw Exception('Failed to update post: $e');
    }
  }
}